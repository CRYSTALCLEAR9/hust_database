import java.sql.*;

public class Transform {
    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/sparsedb?allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF8&useSSL=false&serverTimezone=UTC";
    static final String USER = "root";
    static final String PASS = "123123";

    /**
     * 向sc表中插入数据
     *
     */
    public static void insertSC(Connection con, int sno, String col_name, int col_value) {
        try {
            String sql = "insert into sc values (?, ?, ?)";
            PreparedStatement psl = con.prepareStatement(sql);
            psl.setInt(1, sno);
            psl.setString(2, col_name);
            psl.setInt(3, col_value);
            psl.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws Exception {
        Class.forName(JDBC_DRIVER);
        Connection con = DriverManager.getConnection(DB_URL, USER, PASS);
        String[] subject = {"chinese", "math", "english", "physics", "chemistry", "biology", "history", "geography", "politics"};
        try {
            ResultSet res = con.createStatement().executeQuery("select * from entrance_exam");
            while (res.next()) {
                int sno = res.getInt("sno"), score;
                for (String sub : subject) {
                    score = res.getInt(sub);
                    if (!res.wasNull())
                        insertSC(con, sno, sub, score);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
    }
}