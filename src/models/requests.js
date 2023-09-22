import database from '../database/mysql.js'
import { formatDate } from '../utils/formatDate.js'

export class RequestsModel {
  static async getAll () {
    const requests = await database.query(
        `SELECT *
        FROM Requests
        ORDER BY ID;`
    )
    return requests
  }

  static async getById (id) {
    const request = await database.query(
        `SELECT *
        FROM Requests
        WHERE ID = ?;`,
        [id]
    )
    return request
  }

  static async create (data) {
    const RequestDate = formatDate(new Date())
    const RequestStatus = 'Pending'
    const {
      BorrowDate,
      StartTime,
      EndTime,
      ClassroomID,
      ActivityDescription,
      UserID,
      ProgramID
    } = data
    const created = await database.query(
        `INSERT INTO Requests
        (   RequestDate,
            BorrowDate,
            StartTime,
            EndTime,
            ClassroomID,
            ActivityDescription,
            RequestStatus,
            UserID,
            ProgramID)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);`,
        [RequestDate, BorrowDate, StartTime, EndTime, ClassroomID, ActivityDescription, RequestStatus, UserID, ProgramID]
    )
    return created
  }

  static async update (data, id) {
    const {
      BorrowDate,
      StartTime,
      EndTime,
      ClassroomID,
      ActivityDescription,
      RequestStatus,
      UserID,
      ProgramID,
      ApprovedBy,
      ClosedBy
    } = data
    const updated = await database.query(
        `UPDATE Requests
        SET BorrowDate = ?,
        StartTime = ?,
        EndTime = ?,
        ClassroomID = ?,
        ActivityDescription = ?,
        RequestStatus = ?,
        UserID = ?,
        ProgramID = ?,
        ApprovedBy = ?,
        ClosedBy = ?
        WHERE ID = ?;`,
        [BorrowDate,
          StartTime,
          EndTime,
          ClassroomID,
          ActivityDescription,
          RequestStatus,
          UserID,
          ProgramID,
          ApprovedBy,
          ClosedBy, id]
    )
    return updated
  }

  static async delete (id) {
    const deleted = await database.query(
        `DELETE FROM Requests
        WHERE ID = ?;`,
        [id]
    )
    return deleted
  }
}
