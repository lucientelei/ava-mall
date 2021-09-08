import com.lucien.mall.FrontApiApplication;
import com.lucien.mall.utils.JWTUtils;
import com.lucien.mall.utils.RedisUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.UUID;

/**
 * @Author Lucien
 * @Date 2021/9/8
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = FrontApiApplication.class)
public class FrontApplicationTest {

    @Autowired
    private RedisUtils redisUtils;

    @Test
    public void SetRedis(){
        redisUtils.set("TestKey:" + UUID.randomUUID(), "test to set redis", JWTUtils.EXPIRE_TIME);
    }

    @Test
    public void GetRedis(){
        String testKey = redisUtils.get("TOKENADMIN:" + "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MzEwNzg2OTMsInVzZXJuYW1lIjoibHVjaWVuIn0.J3d2y_saNvYYiJIYw5M61s_G6_EfSIqWzrPAdp-7k5M");
        System.out.println(testKey);
    }

    @Test
    public void ttlRedis(){
        long ttl = redisUtils.ttl("TOKENADMIN:" + "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MzEwNzg2OTMsInVzZXJuYW1lIjoibHVjaWVuIn0.J3d2y_saNvYYiJIYw5M61s_G6_EfSIqWzrPAdp-7k5M");
        System.out.println(ttl);
    }

    @Test
    public void delRedis(){
        redisUtils.del("TOKENADMIN:" + "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MzEwNzg2OTMsInVzZXJuYW1lIjoibHVjaWVuIn0.J3d2y_saNvYYiJIYw5M61s_G6_EfSIqWzrPAdp-7k5M");
    }
}
