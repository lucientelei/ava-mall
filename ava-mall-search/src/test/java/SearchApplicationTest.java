import com.lucien.mall.search.SearchApplication;
import com.lucien.mall.utils.RedisUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

/**
 * @Author Lucien
 * @Date 2021/9/7
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = SearchApplication.class)
public class SearchApplicationTest {

    @Autowired
    private RedisUtils redisUtils;

    @Test
    public void SetRedis(){
        redisUtils.set("TestKey", "测试测试redis");
    }

    @Test
    public void GetRedis(){
        String testKey = redisUtils.get("TestKey");
        System.out.println(testKey);
    }

}
