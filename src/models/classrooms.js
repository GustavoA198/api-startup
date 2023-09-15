import database from '../database/mysql.js'

export class ClassroomModel {
  static async getAll () {
    const classrooms = await database.query(
      'SELECT Classroom.ID, Classroom.ClassroomName, Classroom.CampusID, Campus.CampusName FROM Classrooms as Classroom INNER JOIN Campuses as Campus ON Classroom.CampusID = Campus.ID;'
    )
    return classrooms
  }

  static async getById (id) {
    const classroom = await database.query(
      `SELECT Classroom.ID, Classroom.ClassroomName, Classroom.CampusID, Campus.CampusName FROM Classrooms as Classroom INNER JOIN Campuses as Campus ON Classroom.CampusID = Campus.ID
      WHERE Classroom.ID = ?;`,
      [id]
    )
    return classroom
  }

  static async create (data) {
    const { ClassroomName, CampusID } = data
    const added = await database.query(
        `INSERT INTO Classrooms
        (ClassroomName, CampusID)
        VALUES (?, ?);`,
        [ClassroomName, CampusID]
    )
    return added
  }

  static async update (data, id) {
    const { ClassroomName, CampusID } = data
    const updated = await database.query(
      `UPDATE Classrooms
      SET ClassroomName = ?, CampusID = ?
      WHERE ID = ?;`,
      [ClassroomName, CampusID, id]
    )
    return updated
  }

  static async delete (id) {
    const deleted = await database.query(
      `DELETE FROM Classrooms
      WHERE ID = ?;`,
      [id]
    )
    return deleted
  }
}
