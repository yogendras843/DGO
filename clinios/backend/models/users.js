var sql = require('../bin/db.js');

var Users = {

    //user login and verify
    getByEmail: async (email, ip) => {
        try {
            var query = "SELECT * FROM user WHERE email = ?";
            var result = await sql.query(query, email);
            if (result[0].length) {

                //basic data
                var user_id = result[0][0].id;
                var client_id = result[0][0].client_id;

                //save login
                //var query = "update user set signin_dt=now() where id = ?";
                //var result2 = await sql.query(query, [user_id]);
                var query = "insert into user_login values (?, ?, now(), ?)";
                var result2 = await sql.query(query, [user_id, client_id, ip]);

                //TEMP
                var query = "delete from user_login where dt < date_sub(now(), interval 12 hour)";
                var result2 = await sql.query(query);
                var query = "delete from user_log where dt < date_sub(now(), interval 12 hour)";
                var result2 = await sql.query(query);
                var query = "delete from user_schedule where start_event < date_sub(now(), interval 2 month)";
                var result2 = await sql.query(query);
            return result[0];
            } else {
                return { error: "Can not find the user with the email address."}
            }
        } catch (err) {
            return { error: err.message }
        }
    },

    //password reset
    getByToken: async (token) => {
        try {
            var query = "SELECT * FROM user WHERE verify_token = ?";
            var result = await sql.query(query, [token]);
            if (result[0].length) {            
                return result[0];
            } else {
                return { error: "Can not find the user with the verify token."}
            }
        } catch (err) {
            return { error: err.message }
        }
    },

    //initial page load select all
    getAll: async (data) => {
        try {
            var query = "SELECT * FROM user WHERE client_id = ?";
            var result = await sql.query(query, [data.client_id]);
            return {users: result[0]};
        } catch (err) {
            return { error: err.message }
        }
    },

    //select one user
    getById: async (id) => {
        try {
            var query = "SELECT * FROM user WHERE id = ?";
            var result = await sql.query(query, [id]);
            if (result[0].length) return { user: result[0][0] };
        } catch (err) {
            return { error: err.message }
        }
        return new Promise((resolve, reject) => {
            var query = "SELECT * FROM user WHERE id = ?";
            sql.query(query, id, (err, result) => {
                if (err) reject(err);
                resolve(result);
            });
        })
    },

    create: async (data) => {
        var query, result;
        try {
            query = "SELECT COUNT(*) as count FROM user WHERE client_id = ? AND email = ? limit 1";
            result = await sql.query(query, [data.client_id, data.email]);
            if (result[0][0].count) return { error: "Error the email addresss already exists."}
        } catch (err) {
            return { error: err.message }
        }

        try {
            query = "INSERT INTO user SET ?";
            result = await sql.query(query, [data]);
            return { user: result[0][0] }
        } catch (err) {
            return { error: err.message }
        }
    },    

    updateById: async (id, data) => {
        var result1, result2, query;
        try {
            query = "SELECT * FROM user WHERE id = ? /*before update*/"
            result1 = await sql.query(query, [id]);
            if (parseInt(result1[0][0].admin) && data.admin != undefined && data.admin == 0) { //if before admin is true, and now is false   //changed data.admin == 1 to data.admin == 0
                try {
                    query = "SELECT COUNT(*) as count FROM user WHERE client_id = ? AND id <> ? AND admin = ?";
                    result2 = await sql.query(query, [data.client_id, parseInt(id), true]);
                    if (!result2[0][0].count) return { error: "There must be at least one user that is an administrator." };
                } catch (err) {
                    return { error: err.message }
                }
            }
            if (data.email && result1[0][0].email != data.email) {
                try {
                    query = "SELECT COUNT(*) as count FROM user WHERE id <> ? AND email = ?";
                    result2 = await sql.query(query, [id, data.email]);
                    if (result2[0][0].count) return { error: "Error the email address already exists." };
                } catch (err) {
                    return { error: err.message }
                }
            }
        } catch (err) {
            return { error: err.message }
        }
        try {
            query = "UPDATE user SET ? WHERE id = ?";
            result = await sql.query(query, [{...data}, id]);
            query1 = "SELECT * FROM user WHERE id = ? /*after update*/"
            result1 = await sql.query(query1, [id]);
            return { user: result1[0][0] };
        } catch (err) {
            return { error: err.message }
        }
    },

    deleteById: async (client_id, id) => {
        var result, query = "SELECT client_id from user WHERE id = ?";
        try {
            result = await sql.query(query, [id]);
            if (result[0][0].client_id != client_id) return { error: "Security violation" };
        } catch (err) {
            return { error: err.message }
        }

        query = "SELECT COUNT(*) AS count FROM user WHERE client_id = ? AND admin = ? AND id <> ?";
        try {
            result = await sql.query(query, [client_id, true, id]);
            if (!result[0][0].count) return { error: "There must be at least one user that is an administrator.  Set another user as an administrator and then try again." };
        } catch (err) {
            return { error: err.message }
        }

        query = "SELECT COUNT(*) AS count FROM patient_message WHERE client_id = ? AND (user_id_from = ? OR user_id_to = ?)";
        try {
            result = await sql.query(query, [client_id, id, id]);
            if (result[0][0].count) return { error: "This user is associated with a patient message and therefore cannot be deleted." };
        } catch (err) {
            return { error: err.message }
        }
        query = "SELECT COUNT(*) AS count FROM encounter WHERE client_id = ? AND user_id = ?";
        try {
            result = await sql.query(query, [client_id, id]);
            if (result[0][0].count) return { error: "This user is associated with a patient encounter and therefore cannot be deleted." };
        } catch (err) {
            return { error: err.message };
        }

        query = "SELECT COUNT(*) AS count FROM user WHERE client_id = ? AND updated_user_id = ?";
        try {
            result = await sql.query(query, [client_id, id]);
            if (result[0][0].count) return {  error: "This user is associated with another user update and therefore cannot be deleted." };
        } catch (err) {
            return { error: err.message };
        }

        query = "SELECT COUNT(*) AS count FROM patient WHERE client_id = ? AND created_user_id = ?";
        try {
            result = await sql.query(query, [client_id, id]);
            if (result[0][0].count) return { error: "This user is associated with another patient creation and therefore cannot be deleted." };
        } catch (err) {
            return { error: err.message };
        }

        query = "SELECT COUNT(*) AS count FROM patient WHERE client_id = ? AND updated_user_id = ?";
        try {
            result = await sql.query(query, [client_id, id]);
            if (result[0][0].count) return { error: "This user is associated with another patient update and therefore cannot be deleted." };
        } catch (err) {
            return { error: err.message };
        }
            
        query = "SELECT COUNT(*) AS count FROM user_calendar WHERE client_id = ? AND user_id = ?";
        try {
            result = await sql.query(query, [client_id, id]);
            if (result[0][0].count) return { error: "This user is associated with a patient calendar and therefore cannot be deleted." }
        } catch (err) {
            return { error: err.message };
        }
        
        query = "DELETE FROM user WHERE client_id = ? AND id = ?";
        try {
            result = await sql.query(query, [client_id, id]);
            return { user: result[0][0] };
        } catch(err) {
            return { error: err.message }
        }
    },

    workflow: async (data) => {
        var query, result;
        try {
            query = `
                select u.id, concat(u.firstname, ' ', u.lastname) name, pm.count, pm.created from (
                select pm.user_id_to, count(*) count, max(created) created 
                from patient_message pm
                where client_id = ?
                group by pm.user_id_to
                ) pm
                left join user u on u.id=pm.user_id_to
                `;
            result = await sql.query(query, [data.client_id]);
            if (result[0].length) {
                return result[0]
            } else {
                return []
            }
        } catch (err) {
            return { error: err.message }
        }
    },

}

module.exports = Users;