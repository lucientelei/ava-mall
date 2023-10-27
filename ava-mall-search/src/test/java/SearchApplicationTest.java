import com.lucien.mall.search.SearchApplication;
import org.apache.lucene.search.TotalHits;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.text.Text;
import org.elasticsearch.common.unit.TimeValue;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightBuilder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.elasticsearch.core.ElasticsearchRestTemplate;
import org.springframework.test.context.junit4.SpringRunner;

import java.io.IOException;
import java.util.Map;

/**
 * @Author Lucien
 * @Date 2023/9/7
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = SearchApplication.class)
public class SearchApplicationTest {

    private static final Logger log = LoggerFactory.getLogger(SearchApplicationTest.class);

    @Autowired
    private RestHighLevelClient esClient;

    @Autowired
    private ElasticsearchRestTemplate elasticsearchRestTemplate;

    @Test
    public void search() throws IOException {
        String keyWord = "手机";
        QueryBuilder builder =  QueryBuilders.multiMatchQuery(keyWord, "brandName","name","keywords","subTitle");
        //设置高亮字段
        HighlightBuilder highlightBuilder = new HighlightBuilder();
        highlightBuilder.field("brandName");
        highlightBuilder.field("name");
        highlightBuilder.field("keywords");
        highlightBuilder.field("subTitle");


        SearchRequest searchRequest = new SearchRequest("pms");
        SearchSourceBuilder sourceBuilder = new SearchSourceBuilder();
        sourceBuilder.query(builder);
        sourceBuilder.from(0);
        sourceBuilder.size(10);
        sourceBuilder.highlighter(highlightBuilder);
        sourceBuilder.timeout(new TimeValue(1000));
        searchRequest.source(sourceBuilder);

        SearchResponse response = esClient.search(searchRequest, RequestOptions.DEFAULT);
        SearchHits searchHits = response.getHits();
        TotalHits totalHits = searchHits.getTotalHits();

        log.info("totalHits:" + totalHits);

        SearchHit[] hits = searchHits.getHits();
        for (SearchHit hit : hits) {
            Map sourceAsMap = hit.getSourceAsMap();

            log.info("文档ID:" + hit.getId());
            log.info("文档得分:" + hit.getScore());

            if (hit.getHighlightFields().get("name") != null){
                Text[] texts = hit.getHighlightFields().get("name").getFragments();
                String name = "";
                for (Text text : texts) {
                    name += text;
                }
                log.info("文档字段name:" + name);
            }else {
                log.info("文档字段name:" + sourceAsMap.get("name"));
            }
        }
    }

}
