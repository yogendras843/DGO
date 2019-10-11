var sql = require('../bin/db.js');

var Patients = {

    //livesearch at the top right of Header.Vue
    getFilter: async (search, client_id) => {
        var query, result;
        search=search+"%";
        try {
            query = "SELECT * FROM patient WHERE client_id = ? and (firstname LIKE ? OR lastname LIKE ? OR email LIKE ?) limit 10";
            result = await sql.query(query, [client_id, search, search, search]);
            return {patients: result[0]};
        } catch (err) {
            return { error: err.message }
        }
    },

    /*
    getAll: async () => {
        var query, result;
        try {
            query = "SELECT * FROM patient"; // add where client_id = ?";
            result = await sql.query(query); // add client_id
            if (result[0].length) {
                return result[0]
            } else {
                return { error: "There are no patients."}
            }
        } catch (err) {
            return { error: err.message }
        }
    },
    */

    searchPatients: async (search) => {
        var query, result, i;
        try {
            query = `SELECT * FROM patient WHERE client_id = ?`
            if (search.first != '') {
                query += ` AND firstname LIKE '${search.first}%'`
                i++;
            }
            if (search.last != '') {
                query += ` AND lastname LIKE '${search.last}%'`
                i++;
            }
            if (search.email != '') {
                query += ` AND email LIKE '${search.email}%'`
                i++;
            }
            if (search.phone != '') {
                query += ` AND phone LIKE '${search.phone}%'`
                i++;
            }
            query += ` LIMIT 30 /*searchPatients()*/`
            result = await sql.query(query, [search.client_id]);
            if (result[0].length) {
                return result[0]
            } else {
                return []
            }
        } catch (err) {
            return { error: err.message }
        }
    },
   
    getById: async (id) => {
        var query, result;
        try {
            query = "SELECT * FROM patient WHERE id = ?";
            result = await sql.query(query, [id]);
            if (result[0].length) {
                return { patient: result[0][0] }
            } else {
                return { error: "Can not find a patient with this id." }
            }
        } catch (err) {
            return { error: err.message}
        }
    },

    insertUserLog: async (data) => {
        var query, result;
        try {
            query = "INSERT INTO user_log SET ?";
            result = await sql.query(query, [data]);
            return result[0][0];
        } catch (err) {
            return { error: err.message }
        }
    },
    
    updateById: async (id, data) => {
        var query, result;
        try {
            query = "SELECT * FROM patient WHERE id = ?"
            result1 = await sql.query(query, [id]);

            if (data.email && result1[0][0].email != data.email) {
                try {
                    query = "SELECT COUNT(*) as count FROM user WHERE id <> ? AND email = ?";
                    result2 = await sql.query(query, [id, data.email]);
                    if (result2[0][0].count) return { error: "Error the email address already exists." };
                } catch (err) {
                    return { error: err.message }
                }
            }

            try {
                query = "UPDATE patient SET ? WHERE id = ?";
                result = await sql.query(query, [data, id]);
                return {patient: result[0][0]};
            } catch (err) {
                return { error: err.message }
            }

        } catch (err) {
            return { error: err.message }
        }

    },

    //seems to be unused
    create: async (data) => {
        var query, result;
        try {
            query = "INSERT INTO patient SET ?";
            result = await sql.query(query, data);
            return { user: result[0] }
        } catch (err) {
            return { error: err.message }
        }
    },


    ////////////////////
    //patient portal
    ////////////////////

    //patient login and verify
    getByEmail: async (email) => {
        var query, result;
        try {
            query = "SELECT * FROM patient WHERE email = ?";
            result = await sql.query(query, [email]);
            if (result[0].length) {
                return result[0][0];
            } else {
                return { error: "Can not find the patient with the email address." }
            }
        } catch (err) {
            return { error: err.message }
        }
    },

    //reset password
    getByToken: async (token) => {
        var query, result;
        try {
            query = "SELECT * FROM patient WHERE verify_token = ?";
            result = await sql.query(query, [token]);
            if (result[0].length) {
                return result[0][0];
            } else {
                return { error: "Can not find the patient with the verify token." };
            }
        } catch (err) {
            return { error: err.message }
        }
    },

    //seems to be unused
    deleteById: async (id) => {
        var query, result;
        try {
            query = "DELETE FROM patient WHERE id = ?";
            result = await sql.query(query, [id]);
            return result[0];
        } catch (err) {
            return { error: err.message }
        }
    },

}

module.exports = Patients;