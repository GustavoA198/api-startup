import z from 'zod'
import { dateTimeValidator } from '../utils/validatorDate.js'

const RequestSchema = z.object({
  RequestDate: dateTimeValidator,
  BorrowDate: z.string().nullable().refine(value => value === null || dateTimeValidator.safeParse(value).success, { message: 'La fecha y hora deben estar en formato "YYYY-MM-DD HH:MM:SS" o nula' }),
  StartTime: dateTimeValidator,
  EndTime: dateTimeValidator,
  ClassroomID: z.number().int().positive(),
  ActivityDescription: z.string().nonempty(),
  RequestStatus: z.enum(['Pending', 'Approved', 'Closed']),
  UserID: z.string().trim().uuid(),
  ProgramID: z.number().int().positive(),
  ApprovedBy: z.string().trim().uuid().nullable(),
  ClosedBy: z.string().trim().uuid().nullable()
});

export function validateRequest (input) {
  console.log(input)
  return RequestSchema.safeParse(input)
}

export function validatePartialRequest (input) {
  return RequestSchema.partial().safeParse(input)
}
