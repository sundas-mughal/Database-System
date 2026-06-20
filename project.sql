--hospital management system 
create database hospitalmanagementsystem;
use hospitalmanagementsystem;
create table person
(
    person_id int identity(1,1) primary key,
    first_name varchar(50),
    last_name varchar(50),
    gender varchar(10),
    dob date,
    phone varchar(15),
    email varchar(100),
    address varchar(200),
    created_at datetime default getdate()
);
-- 1. patient management
create table patients
(
    patient_id int identity(1,1) primary key,
    -- generalization link
    person_id int,
    blood_group varchar(5),
    foreign key(person_id)
    references person(person_id)
);
create table patient_registration
(
    registration_id int identity(1,1) primary key,
    patient_id int,
    registration_date date,
    registration_status varchar(20),
    foreign key(patient_id)
    references patients(patient_id)
);
create table patient_visits
(
    visit_id int identity(1,1) primary key,
    patient_id int,
    doctor_id int,
    visit_date datetime,
    reason text,
    foreign key(patient_id)
    references patients(patient_id)
);
create table patient_history
(
    history_id int identity(1,1) primary key,
    patient_id int,
    medical_history text,
    surgeries text,
    chronic_diseases text,
    foreign key(patient_id)
    references patients(patient_id)
);
create table patient_allergies
(
    allergy_id int identity(1,1) primary key,
    patient_id int,
    allergy_name varchar(100),
    reaction text,
    foreign key(patient_id)
    references patients(patient_id)
);
create table patient_diagnosis
(
    diagnosis_id int identity(1,1) primary key,
    patient_id int,
    doctor_id int,
    diagnosis text,
    diagnosis_date date,

    foreign key(patient_id)
    references patients(patient_id)
);
create table patient_insurance
(
    insurance_id int identity(1,1) primary key,
    patient_id int,
    provider_name varchar(100),
    policy_number varchar(50),
    expiry_date date,

    foreign key(patient_id)
    references patients(patient_id)
);



create table patient_emergency_contacts
(
    contact_id int identity(1,1) primary key,
    patient_id int,
    contact_name varchar(100),
    relation varchar(50),
    phone varchar(15),

    foreign key(patient_id)
    references patients(patient_id)
);



create table patient_addresses
(
    address_id int identity(1,1) primary key,
    patient_id int,
    address text,
    city varchar(50),
    state varchar(50),
    zip_code varchar(10),

    foreign key(patient_id)
    references patients(patient_id)
);



create table patient_feedback
(
    feedback_id int identity(1,1) primary key,
    patient_id int,
    feedback text,
    rating int,
    feedback_date date,

    foreign key(patient_id)
    references patients(patient_id)
);

------------------------------------------------
-- 2. doctor management
------------------------------------------------


-- doctor specialization
create table doctor_specializations
(
    specialization_id int identity(1,1) primary key,
    specialization_name varchar(100)
);



-- doctor departments
create table doctor_departments
(
    department_id int identity(1,1) primary key,
    department_name varchar(100)
);



-- doctor entity (generalization from person)

create table doctors
(
    doctor_id int identity(1,1) primary key,

    -- generalization link
    person_id int,

    specialization_id int,
    department_id int,

    experience_years int,


    foreign key(person_id)
    references person(person_id),


    foreign key(specialization_id)
    references doctor_specializations(specialization_id),


    foreign key(department_id)
    references doctor_departments(department_id)
);



-- doctor schedules

create table doctor_schedules
(
    schedule_id int identity(1,1) primary key,
    doctor_id int,
    available_day varchar(20),
    start_time time,
    end_time time,

    foreign key(doctor_id)
    references doctors(doctor_id)
);



-- doctor availability

create table doctor_availability
(
    availability_id int identity(1,1) primary key,
    doctor_id int,
    available_date date,
    status varchar(20),

    foreign key(doctor_id)
    references doctors(doctor_id)
);



-- doctor qualifications

create table doctor_qualifications
(
    qualification_id int identity(1,1) primary key,
    doctor_id int,
    qualification varchar(100),
    institute varchar(100),

    foreign key(doctor_id)
    references doctors(doctor_id)
);



-- doctor reviews

create table doctor_reviews
(
    review_id int identity(1,1) primary key,
    doctor_id int,
    patient_id int,
    review text,
    rating int,


    foreign key(doctor_id)
    references doctors(doctor_id),


    foreign key(patient_id)
    references patients(patient_id)
);



-- doctor attendance

create table doctor_attendance
(
    attendance_id int identity(1,1) primary key,
    doctor_id int,
    attendance_date date,
    status varchar(20),

    foreign key(doctor_id)
    references doctors(doctor_id)
);
--nurses
CREATE TABLE nurses
(
    nurse_id INT IDENTITY(1,1) PRIMARY KEY,
    person_id INT,
    department_id INT,
    qualification VARCHAR(100),
    experience_years INT,
    shift_type VARCHAR(20), -- Morning, Evening, Night
    FOREIGN KEY(person_id)
    REFERENCES person(person_id),
    FOREIGN KEY(department_id)
    REFERENCES doctor_departments(department_id)
);
--Nurse Attendance
CREATE TABLE nurse_attendance
(
    attendance_id INT IDENTITY(1,1) PRIMARY KEY,

    nurse_id INT,

    attendance_date DATE,

    status VARCHAR(20),

    FOREIGN KEY(nurse_id)
    REFERENCES nurses(nurse_id)
);
--Nurse Schedule
CREATE TABLE nurse_schedules
(
    schedule_id INT IDENTITY(1,1) PRIMARY KEY,

    nurse_id INT,

    available_day VARCHAR(20),

    start_time TIME,

    end_time TIME,

    FOREIGN KEY(nurse_id)
    REFERENCES nurses(nurse_id)
);
--Nurse Assignments (Ward/Room/Bed)
CREATE TABLE nurse_assignments
(
    assignment_id INT IDENTITY(1,1) PRIMARY KEY,

    nurse_id INT,

    ward_id INT,

    room_id INT,

    assigned_date DATE,

    FOREIGN KEY(nurse_id)
    REFERENCES nurses(nurse_id),

    FOREIGN KEY(ward_id)
    REFERENCES wards(ward_id),

    FOREIGN KEY(room_id)
    REFERENCES rooms(room_id)
);
------------------------------------------------
-- 3. appointment system
------------------------------------------------


-- appointments

create table appointments
(
    appointment_id int identity(1,1) primary key,

    patient_id int,
    doctor_id int,

    appointment_date datetime,

    status_id int,


    foreign key(patient_id)
    references patients(patient_id),


    foreign key(doctor_id)
    references doctors(doctor_id)
);



-- appointment slots

create table appointment_slots
(
    slot_id int identity(1,1) primary key,

    doctor_id int,

    slot_date date,

    start_time time,

    end_time time,


    foreign key(doctor_id)
    references doctors(doctor_id)
);



-- appointment status

create table appointment_status
(
    status_id int identity(1,1) primary key,

    status_name varchar(50)
);



-- appointment reminders

create table appointment_reminders
(
    reminder_id int identity(1,1) primary key,

    appointment_id int,

    reminder_date datetime,

    reminder_type varchar(50),


    foreign key(appointment_id)
    references appointments(appointment_id)
);



-- appointment history

create table appointment_history
(
    history_id int identity(1,1) primary key,

    appointment_id int,

    old_status varchar(50),

    new_status varchar(50),

    changed_at datetime default getdate(),


    foreign key(appointment_id)
    references appointments(appointment_id)
);



-- walk-in appointments

create table walkin_appointments
(
    walkin_id int identity(1,1) primary key,

    patient_id int,

    doctor_id int,

    visit_time datetime,


    foreign key(patient_id)
    references patients(patient_id),


    foreign key(doctor_id)
    references doctors(doctor_id)
);





------------------------------------------------
-- 4. billing & finance
------------------------------------------------


-- bills

create table bills
(
    bill_id int identity(1,1) primary key,

    patient_id int,

    total_amount decimal(10,2),

    bill_date date,


    foreign key(patient_id)
    references patients(patient_id)
);



-- bill details

create table bill_details
(
    detail_id int identity(1,1) primary key,

    bill_id int,

    service_name varchar(100),

    amount decimal(10,2),


    foreign key(bill_id)
    references bills(bill_id)
);



-- payments

create table payments
(
    payment_id int identity(1,1) primary key,

    bill_id int,

    payment_date date,

    amount_paid decimal(10,2),

    payment_method_id int,


    foreign key(bill_id)
    references bills(bill_id)
);



-- payment methods

create table payment_methods
(
    payment_method_id int identity(1,1) primary key,

    method_name varchar(50)
);

------------------------------------------------
-- 5. pharmacy management
------------------------------------------------


-- medicines

create table medicines
(
    medicine_id int identity(1,1) primary key,

    medicine_name varchar(100),

    category_id int,

    price decimal(10,2),

    expiry_date date
);



-- medicine categories

create table medicine_categories
(
    category_id int identity(1,1) primary key,

    category_name varchar(100)
);



-- medicine stock

create table medicine_stock
(
    stock_id int identity(1,1) primary key,

    medicine_id int,

    quantity int,


    foreign key(medicine_id)
    references medicines(medicine_id)
);



-- prescriptions

create table prescriptions
(
    prescription_id int identity(1,1) primary key,

    patient_id int,

    doctor_id int,

    prescription_date date,


    foreign key(patient_id)
    references patients(patient_id),


    foreign key(doctor_id)
    references doctors(doctor_id)
);



-- prescription details

create table prescription_details
(
    detail_id int identity(1,1) primary key,

    prescription_id int,

    medicine_id int,

    dosage varchar(100),

    duration varchar(50),


    foreign key(prescription_id)
    references prescriptions(prescription_id),


    foreign key(medicine_id)
    references medicines(medicine_id)
);





------------------------------------------------
-- 6. lab management
------------------------------------------------


-- lab tests

create table lab_tests
(
    test_id int identity(1,1) primary key,

    test_name varchar(100),

    price decimal(10,2)
);



-- test categories

create table test_categories
(
    category_id int identity(1,1) primary key,

    category_name varchar(100)
);



-- test requests

create table test_requests
(
    request_id int identity(1,1) primary key,

    patient_id int,

    doctor_id int,

    test_id int,

    request_date date,


    foreign key(patient_id)
    references patients(patient_id),


    foreign key(doctor_id)
    references doctors(doctor_id),


    foreign key(test_id)
    references lab_tests(test_id)
);



-- lab reports

create table lab_reports
(
    report_id int identity(1,1) primary key,

    request_id int,

    report_details text,

    report_date date,


    foreign key(request_id)
    references test_requests(request_id)
);





------------------------------------------------
-- 7. ward & bed management
------------------------------------------------


-- wards

create table wards
(
    ward_id int identity(1,1) primary key,

    ward_name varchar(100)
);



-- rooms

create table rooms
(
    room_id int identity(1,1) primary key,

    ward_id int,

    room_number varchar(20),


    foreign key(ward_id)
    references wards(ward_id)
);



-- beds

create table beds
(
    bed_id int identity(1,1) primary key,

    room_id int,

    bed_number varchar(20),

    status_id int,


    foreign key(room_id)
    references rooms(room_id)
);



-- bed status

create table bed_status
(
    status_id int identity(1,1) primary key,

    status_name varchar(50)
);

------------------------------------------------
-- 8. staff management
------------------------------------------------


-- staff roles

create table staff_roles
(
    role_id int identity(1,1) primary key,

    role_name varchar(100)
);



-- staff entity (generalization from person)

create table staff
(
    staff_id int identity(1,1) primary key,

    -- generalization link
    person_id int,

    role_id int,

    department_id int,

    salary decimal(10,2),


    foreign key(person_id)
    references person(person_id),


    foreign key(role_id)
    references staff_roles(role_id)
);



-- staff attendance

create table staff_attendance
(
    attendance_id int identity(1,1) primary key,

    staff_id int,

    attendance_date date,

    status varchar(20),


    foreign key(staff_id)
    references staff(staff_id)
);





------------------------------------------------
-- 9. inventory management
------------------------------------------------


-- inventory categories

create table inventory_categories
(
    category_id int identity(1,1) primary key,

    category_name varchar(100)
);



-- inventory items

create table inventory_items
(
    item_id int identity(1,1) primary key,

    item_name varchar(100),

    category_id int,

    quantity int
);



-- vendors

create table vendors
(
    vendor_id int identity(1,1) primary key,

    vendor_name varchar(100),

    phone varchar(15)
);





------------------------------------------------
-- 10. admin & security
------------------------------------------------


-- roles

create table roles
(
    role_id int identity(1,1) primary key,

    role_name varchar(50)
);



-- users

create table users
(
    user_id int identity(1,1) primary key,

    username varchar(50) unique,

    password_hash varchar(255),

    role_id int
);
-- permissions
create table permissions
(
    permission_id int identity(1,1) primary key,
    permission_name varchar(100)
);
-- user logins
create table user_logins
(
    login_id int identity(1,1) primary key,
    user_id int,
    login_time datetime,
    logout_time datetime,
    foreign key(user_id)
    references users(user_id)
);
-----------------------------------------------
-- 11. advanced modules
------------------------------------------------
-- ambulance services
create table ambulance_services
(
    ambulance_id int identity(1,1) primary key,
    vehicle_number varchar(20),
    driver_name varchar(100),
    status varchar(20)
);
-- ambulance requests
create table ambulance_requests
(
    request_id int identity(1,1) primary key,
    patient_id int,
    ambulance_id int,
    request_time datetime,
    foreign key(patient_id)
    references patients(patient_id),
    foreign key(ambulance_id)
    references ambulance_services(ambulance_id)
);
-- emergency cases
create table emergency_cases
(
    case_id int identity(1,1) primary key,
    patient_id int,
    emergency_level varchar(50),
    admitted_at datetime,
    foreign key(patient_id)
    references patients(patient_id)
);
-- operation theaters
create table operation_theaters
(
    theater_id int identity(1,1) primary key,
    theater_name varchar(100),
    status varchar(20)
);
-- surgeries
create table surgeries
(
    surgery_id int identity(1,1) primary key,
    patient_id int,
    doctor_id int,
    theater_id int,
    surgery_date datetime,
    foreign key(patient_id)
    references patients(patient_id),
    foreign key(doctor_id)
    references doctors(doctor_id),
    foreign key(theater_id)
    references operation_theaters(theater_id)
);
-- notifications
create table notifications
(
    notification_id int identity(1,1) primary key,
    user_id int,
    message text,
    notification_date datetime,
    foreign key(user_id)
    references users(user_id)
);
-- messages
create table messages
(
    message_id int identity(1,1) primary key,
    sender_id int,
    receiver_id int,
    message text,
    sent_at datetime,
    foreign key(sender_id)
    references users(user_id),
    foreign key(receiver_id)
    references users(user_id)
);
-- reports
create table reports
(
    report_id int identity(1,1) primary key,
    report_name varchar(100),
    generated_by int,
    generated_at datetime,
    foreign key(generated_by)
    references users(user_id)
);
-- backup logs
create table backup_logs
(
    backup_id int identity(1,1) primary key,
    backup_date datetime,
    backup_status varchar(50)
);
-- activity logs
create table activity_logs
(
    activity_id int identity(1,1) primary key,
    user_id int,
    activity text,
    activity_time datetime,
    foreign key(user_id)
    references users(user_id)
);