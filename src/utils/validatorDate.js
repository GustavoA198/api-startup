import { z } from "zod";

// Validador para fechas y horas en formato 'YYYY-MM-DD HH:MM:SS'
export const dateTimeValidator = z.string().refine((value) => {
    const dateTimePattern = /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/;
    return dateTimePattern.test(value);
  }, {
    message: "La fecha y hora deben estar en formato 'YYYY-MM-DD HH:MM:SS'",
    });