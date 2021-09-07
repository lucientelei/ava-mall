import com.lucien.mall.search.SearchApplication;
import com.lucien.mall.search.mapper.EsProductMapper;
import com.lucien.mall.search.pojo.EsProduct;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

/**
 * @Author Lucien
 * @Date 2021/9/7
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = SearchApplication.class)
public class SearchApplicationTest {

    @Autowired
    private EsProductMapper productMapper;

    @Test
    public void testGetAllEsProductList(){
        List<EsProduct> esProductList = productMapper.getAllEsProductList(null);
        for (EsProduct esProduct : esProductList) {
            System.out.println(esProduct.getName());
        }
    }

}
