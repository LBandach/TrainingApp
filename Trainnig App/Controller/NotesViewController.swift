//
//  ViewController.swift
//  Trainnig App
//
//  Created by user on 07.08.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var notesArray: [Note] = []
    //let defaults = UserDefaults()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var notesTabelView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        notesTabelView.delegate = self
        notesTabelView.dataSource = self
        loadData()
    }

    // MARK: TableView Delegate Methods

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = notesArray[indexPath.row].text

        return cell
    }

    // MARK: Data Manipulation Methods

    func saveData() {

        do {
            try context.save()
        } catch {
            print("Error saving data\(error)")
        }
        self.notesTabelView.reloadData()
    }

    func loadData() {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            notesArray =  try context.fetch(request)
        } catch {
            print("Error fetching data \(error)")
        }
        self.notesTabelView.reloadData()
    }

    @IBAction func add(_ sender: UIBarButtonItem) {

        var passedText = UITextField()
        let alert = UIAlertController(title: "Add new note", message: nil, preferredStyle: .alert)

        let action = UIAlertAction(title: "Add", style: .default) { (_) in

            let newNote = Note(context: self.context)
            newNote.text = passedText.text
            self.notesArray.append(newNote)
            self.saveData()
        }

        alert.addTextField { (alertText) in
            alertText.placeholder = "create new note"
            passedText = alertText
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    // MARK: actions

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        context.delete(notesArray[indexPath.row])
        notesArray.remove(at: indexPath.row)

        saveData()
        self.notesTabelView.reloadData()
    }

}
