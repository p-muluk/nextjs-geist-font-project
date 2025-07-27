-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "phone" TEXT,
    "avatar" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "system_admins" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    CONSTRAINT "system_admins_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "institute_groups" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "logo" TEXT,
    "website" TEXT,
    "phone" TEXT,
    "email" TEXT,
    "address" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "group_owners" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "instituteGroupId" TEXT NOT NULL,
    CONSTRAINT "group_owners_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "group_owners_instituteGroupId_fkey" FOREIGN KEY ("instituteGroupId") REFERENCES "institute_groups" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "institutes" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "description" TEXT,
    "logo" TEXT,
    "website" TEXT,
    "phone" TEXT,
    "email" TEXT,
    "address" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "groupId" TEXT,
    CONSTRAINT "institutes_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "institute_groups" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "institute_admins" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "instituteId" TEXT NOT NULL,
    CONSTRAINT "institute_admins_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "institute_admins_instituteId_fkey" FOREIGN KEY ("instituteId") REFERENCES "institutes" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "departments" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "description" TEXT,
    "instituteId" TEXT NOT NULL,
    CONSTRAINT "departments_instituteId_fkey" FOREIGN KEY ("instituteId") REFERENCES "institutes" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "staff" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "instituteId" TEXT NOT NULL,
    "departmentId" TEXT,
    "employeeId" TEXT NOT NULL,
    "position" TEXT NOT NULL,
    "salary" REAL,
    "joinDate" DATETIME NOT NULL,
    CONSTRAINT "staff_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "staff_instituteId_fkey" FOREIGN KEY ("instituteId") REFERENCES "institutes" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "staff_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "departments" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "teachers" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "instituteId" TEXT NOT NULL,
    "departmentId" TEXT,
    "employeeId" TEXT NOT NULL,
    "subject" TEXT,
    "qualification" TEXT,
    "experience" INTEGER,
    "salary" REAL,
    "joinDate" DATETIME NOT NULL,
    CONSTRAINT "teachers_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "teachers_instituteId_fkey" FOREIGN KEY ("instituteId") REFERENCES "institutes" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "teachers_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "departments" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "students" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "instituteId" TEXT NOT NULL,
    "rollNumber" TEXT NOT NULL,
    "admissionDate" DATETIME NOT NULL,
    "dateOfBirth" DATETIME,
    "bloodGroup" TEXT,
    "address" TEXT,
    "emergencyContact" TEXT,
    CONSTRAINT "students_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "students_instituteId_fkey" FOREIGN KEY ("instituteId") REFERENCES "institutes" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "parents" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT NOT NULL,
    "occupation" TEXT,
    "relationship" TEXT NOT NULL,
    CONSTRAINT "parents_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "student_parents" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "studentId" TEXT NOT NULL,
    "parentId" TEXT NOT NULL,
    CONSTRAINT "student_parents_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "students" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "student_parents_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "parents" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "academic_years" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "startDate" DATETIME NOT NULL,
    "endDate" DATETIME NOT NULL,
    "isCurrent" BOOLEAN NOT NULL DEFAULT false,
    "instituteId" TEXT NOT NULL,
    CONSTRAINT "academic_years_instituteId_fkey" FOREIGN KEY ("instituteId") REFERENCES "institutes" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "courses" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "description" TEXT,
    "credits" INTEGER,
    "duration" TEXT,
    "instituteId" TEXT NOT NULL,
    "departmentId" TEXT,
    "academicYearId" TEXT NOT NULL,
    CONSTRAINT "courses_instituteId_fkey" FOREIGN KEY ("instituteId") REFERENCES "institutes" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "courses_departmentId_fkey" FOREIGN KEY ("departmentId") REFERENCES "departments" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "courses_academicYearId_fkey" FOREIGN KEY ("academicYearId") REFERENCES "academic_years" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "course_teachers" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "courseId" TEXT NOT NULL,
    "teacherId" TEXT NOT NULL,
    CONSTRAINT "course_teachers_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "courses" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "course_teachers_teacherId_fkey" FOREIGN KEY ("teacherId") REFERENCES "teachers" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "subjects" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "courseId" TEXT NOT NULL,
    CONSTRAINT "subjects_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "courses" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "enrollments" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "studentId" TEXT NOT NULL,
    "courseId" TEXT NOT NULL,
    "academicYearId" TEXT NOT NULL,
    "enrollmentDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" TEXT NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT "enrollments_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "students" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "enrollments_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "courses" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "enrollments_academicYearId_fkey" FOREIGN KEY ("academicYearId") REFERENCES "academic_years" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "admissions" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "applicationId" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "dateOfBirth" DATETIME NOT NULL,
    "address" TEXT NOT NULL,
    "documents" TEXT,
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "appliedDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "reviewedDate" DATETIME,
    "reviewedBy" TEXT,
    "comments" TEXT,
    "instituteId" TEXT NOT NULL,
    CONSTRAINT "admissions_instituteId_fkey" FOREIGN KEY ("instituteId") REFERENCES "institutes" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "attendance_records" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "studentId" TEXT NOT NULL,
    "teacherId" TEXT,
    "instituteId" TEXT NOT NULL,
    "academicYearId" TEXT NOT NULL,
    "date" DATETIME NOT NULL,
    "status" TEXT NOT NULL,
    "remarks" TEXT,
    CONSTRAINT "attendance_records_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "students" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "attendance_records_teacherId_fkey" FOREIGN KEY ("teacherId") REFERENCES "teachers" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "attendance_records_instituteId_fkey" FOREIGN KEY ("instituteId") REFERENCES "institutes" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "attendance_records_academicYearId_fkey" FOREIGN KEY ("academicYearId") REFERENCES "academic_years" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "libraries" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "instituteId" TEXT NOT NULL,
    CONSTRAINT "libraries_instituteId_fkey" FOREIGN KEY ("instituteId") REFERENCES "institutes" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "books" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "author" TEXT NOT NULL,
    "isbn" TEXT,
    "publisher" TEXT,
    "category" TEXT,
    "totalCopies" INTEGER NOT NULL DEFAULT 1,
    "availableCopies" INTEGER NOT NULL DEFAULT 1,
    "status" TEXT NOT NULL DEFAULT 'AVAILABLE',
    "libraryId" TEXT NOT NULL,
    CONSTRAINT "books_libraryId_fkey" FOREIGN KEY ("libraryId") REFERENCES "libraries" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "library_transactions" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "bookId" TEXT NOT NULL,
    "studentId" TEXT NOT NULL,
    "libraryId" TEXT NOT NULL,
    "issueDate" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dueDate" DATETIME NOT NULL,
    "returnDate" DATETIME,
    "fine" REAL DEFAULT 0,
    "status" TEXT NOT NULL DEFAULT 'ISSUED',
    CONSTRAINT "library_transactions_bookId_fkey" FOREIGN KEY ("bookId") REFERENCES "books" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "library_transactions_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "students" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "library_transactions_libraryId_fkey" FOREIGN KEY ("libraryId") REFERENCES "libraries" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "fee_structures" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "amount" REAL NOT NULL,
    "description" TEXT,
    "dueDate" DATETIME NOT NULL,
    "instituteId" TEXT NOT NULL,
    CONSTRAINT "fee_structures_instituteId_fkey" FOREIGN KEY ("instituteId") REFERENCES "institutes" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "fee_records" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "studentId" TEXT NOT NULL,
    "feeStructureId" TEXT NOT NULL,
    "amountPaid" REAL NOT NULL DEFAULT 0,
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "paidDate" DATETIME,
    "dueDate" DATETIME NOT NULL,
    CONSTRAINT "fee_records_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "students" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "fee_records_feeStructureId_fkey" FOREIGN KEY ("feeStructureId") REFERENCES "fee_structures" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "settings" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "key" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "type" TEXT NOT NULL DEFAULT 'STRING'
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "system_admins_userId_key" ON "system_admins"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "group_owners_userId_key" ON "group_owners"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "group_owners_instituteGroupId_key" ON "group_owners"("instituteGroupId");

-- CreateIndex
CREATE UNIQUE INDEX "institutes_code_key" ON "institutes"("code");

-- CreateIndex
CREATE UNIQUE INDEX "institute_admins_userId_key" ON "institute_admins"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "departments_code_instituteId_key" ON "departments"("code", "instituteId");

-- CreateIndex
CREATE UNIQUE INDEX "staff_userId_key" ON "staff"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "staff_employeeId_instituteId_key" ON "staff"("employeeId", "instituteId");

-- CreateIndex
CREATE UNIQUE INDEX "teachers_userId_key" ON "teachers"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "teachers_employeeId_instituteId_key" ON "teachers"("employeeId", "instituteId");

-- CreateIndex
CREATE UNIQUE INDEX "students_userId_key" ON "students"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "students_rollNumber_instituteId_key" ON "students"("rollNumber", "instituteId");

-- CreateIndex
CREATE UNIQUE INDEX "parents_userId_key" ON "parents"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "student_parents_studentId_parentId_key" ON "student_parents"("studentId", "parentId");

-- CreateIndex
CREATE UNIQUE INDEX "academic_years_name_instituteId_key" ON "academic_years"("name", "instituteId");

-- CreateIndex
CREATE UNIQUE INDEX "courses_code_instituteId_academicYearId_key" ON "courses"("code", "instituteId", "academicYearId");

-- CreateIndex
CREATE UNIQUE INDEX "course_teachers_courseId_teacherId_key" ON "course_teachers"("courseId", "teacherId");

-- CreateIndex
CREATE UNIQUE INDEX "subjects_code_courseId_key" ON "subjects"("code", "courseId");

-- CreateIndex
CREATE UNIQUE INDEX "enrollments_studentId_courseId_academicYearId_key" ON "enrollments"("studentId", "courseId", "academicYearId");

-- CreateIndex
CREATE UNIQUE INDEX "admissions_applicationId_key" ON "admissions"("applicationId");

-- CreateIndex
CREATE UNIQUE INDEX "attendance_records_studentId_date_academicYearId_key" ON "attendance_records"("studentId", "date", "academicYearId");

-- CreateIndex
CREATE UNIQUE INDEX "libraries_instituteId_key" ON "libraries"("instituteId");

-- CreateIndex
CREATE UNIQUE INDEX "fee_records_studentId_feeStructureId_key" ON "fee_records"("studentId", "feeStructureId");

-- CreateIndex
CREATE UNIQUE INDEX "settings_key_key" ON "settings"("key");
