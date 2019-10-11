var sql = require('../bin/db.js');

var Schedules = {
    create: async (data) => {
        var query, result;
        try {
            query = "INSERT INTO user_schedule SET ?";
            result = await sql.query(query, [data]);
            latest = await sql.query("SELECT * FROM user_schedule ORDER BY id DESC LIMIT 1")
            return latest;
        } catch (err) {
            return { error: err.message }
        }
    },    
    copy: async (user_id) => {
        var query, result;
        try {
            query = "insert into user_schedule (user_id, start_event, end_event) select user_id, adddate(max(start_event), 7), adddate(max(end_event), 7) from user_schedule where user_id=" + user_id;
            result = await sql.query(query)
            latest = await sql.query("SELECT * FROM user_schedule ORDER BY id DESC LIMIT 1")
            return latest;
        } catch (err) {
            return { error: err.message }
        }
    },    
    getSchedule: async (id) => {
        try {
            query = "SELECT * FROM user_schedule WHERE user_id=" + id;
            result = await sql.query(query);
            return result;
        } catch (err) {
            return { error: err.message }
        }
    },    
    getUsers: async () => {
        try {
            query = "SELECT id, firstname, lastname FROM user WHERE client_id=1"
            result = await sql.query(query);
            return result;
        } catch (err) {
            return { error: err.message }
        }
    },    
    update: async (data) => {
        
        try {
            query = "UPDATE user_schedule SET start_event='" + data.start_event + "', end_event='" + data.end_event + "' WHERE id=" + data.id;
            result = await sql.query(query);
            return 'updated';
        } catch (err) {
            return { error: err.message }
        }
    },    
    deleteSchedule: async (data) => {
        var query, result;
        try {
            query = "DELETE FROM user_schedule WHERE id = ?";
            result = await sql.query(query, [data.id]);
            return result[0];
        } catch (err) {
            return { error: err.message }
        }
    },  
    
    
    createCalendar: async (data) => {
        var query, result;
        try {
            query = "INSERT INTO user_calendar SET ?";
            result = await sql.query(query, [data]);
            latest = await sql.query("SELECT * FROM user_calendar ORDER BY id DESC LIMIT 1")
            return latest;
        } catch (err) {
            return { error: err.message }
        }
    },    
    copyCalendar: async (user_id) => {
        var query, result;
        try {
            query = "insert into user_calendar (user_id, start_event, end_event) select user_id, adddate(max(start_event), 7), adddate(max(end_event), 7) from user_schedule where user_id=" + user_id;
            result = await sql.query(query)
            latest = await sql.query("SELECT * FROM user_calendar ORDER BY id DESC LIMIT 1")
            return latest;
        } catch (err) {
            return { error: err.message }
        }
    },    
    getCalendar: async (id) => {
        try {
            query = "SELECT u.*, p.firstname FROM user_calendar as u INNER JOIN patient as p WHERE u.user_id=" + id;
            result = await sql.query(query);
            return result;
        } catch (err) {
            console.log("there")
            return { error: err.message }
        }
    },    
    getPatients: async () => {
        try {
            query = "SELECT id, firstname, lastname FROM patient"
            result = await sql.query(query);
            return result;
        } catch (err) {
            return { error: err.message }
        }
    },    
    updateCalendar: async (data) => {
        try {
            query = "UPDATE user_calendar SET start_event='" + data.start_event + "', end_event='" + data.end_event + "' WHERE id=" + data.id;
            result = await sql.query(query);
            return 'updated';
        } catch (err) {
            return { error: err.message }
        }
    },    
    deleteCalendar: async (data) => {
        
        var query, result;
        try {
            query = "DELETE FROM user_calendar WHERE id = ?";
            result = await sql.query(query, [data.id]);
            return result[0];
        } catch (err) {
            return { error: err.message }
        }
    },    
}

module.exports = Schedules;
