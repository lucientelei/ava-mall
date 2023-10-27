package com.lucien.mall.utils;


import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTCreator;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTCreationException;
import com.auth0.jwt.exceptions.JWTDecodeException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.Claim;
import com.auth0.jwt.interfaces.DecodedJWT;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.Calendar;
import java.util.Date;
import java.util.Map;

/**
 * @Author Lucien
 * @Date 2023/8/22
 */
@Component
public class JWTUtils {

    /**
     * 过期时间
     */
    public static final long EXPIRE_TIME = 120 * 120 * 1000;

    /**
     * 制密钥
     */
    public static final String SECRET = "abcdefghijklmnopqrstuvwxyz";

    /**
     * 请求头
     */
    public static final String AUTH_HEADER = "Authorization";

    private static final Logger log = LoggerFactory.getLogger(JWTUtils.class);

    /**
     * 验证token是否正确
     *
     * @param token
     * @param username
     * @return
     */
    public static boolean verify(String token, String username) {
        try {
            Algorithm algorithm = Algorithm.HMAC256(SECRET);
            JWTVerifier jwtVerifier = JWT.require(algorithm).withClaim("username", username).build();
            jwtVerifier.verify(token);
            return true;
        } catch (JWTVerificationException e) {
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 获取token自定义信息
     * 获取token的username，无需secret解密也能获得
     *
     * @param token
     * @param filed
     * @return
     */
    public static String getClaimFiled(String token, String filed) {
        try {
            DecodedJWT decode = JWT.decode(token);
            return decode.getClaim(filed).asString();
        } catch (JWTDecodeException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 生成token
     *
     * @param username
     * @param secret
     * @return
     */
    public static String sign(String username, String secret) {
        try {
            Date date = new Date(System.currentTimeMillis() + EXPIRE_TIME);
            Algorithm algorithm = Algorithm.HMAC256(secret);
            return JWT.create().withClaim("username", username).withExpiresAt(date).sign(algorithm);
        } catch (JWTCreationException e) {
            e.printStackTrace();
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 获取token签发时间
     *
     * @param token
     * @return
     */
    public static Date getIssueAt(String token) {
        try {
            DecodedJWT decode = JWT.decode(token);
            return decode.getIssuedAt();
        } catch (JWTDecodeException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 验证token是否过期
     *
     * @param token
     * @return
     */
    public static boolean isTokenExpired(String token) {
        Date time = Calendar.getInstance().getTime();
        DecodedJWT jwt = JWT.decode(token);
        return jwt.getExpiresAt().before(time);
    }

    /**
     * 刷新token时间
     *
     * @param token
     * @param secret
     * @return
     */
    public static String refreshTokenExpired(String token, String secret) {
        //解析token
        DecodedJWT jwt = JWT.decode(token);
        //获取token的参数信息
        Map<String, Claim> claims = jwt.getClaims();
        try {
            Date date = new Date(System.currentTimeMillis() + EXPIRE_TIME);
            Algorithm algorithm = Algorithm.HMAC256(secret);
            JWTCreator.Builder builder = JWT.create().withExpiresAt(date);
            for (Map.Entry<String, Claim> entry : claims.entrySet()) {
                builder.withClaim(entry.getKey(), entry.getValue().asString());
            }
            return builder.sign(algorithm);
        } catch (JWTCreationException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 生成16位随机盐,用在密码加密上面
     *
     * @return
     */
    public static String generateSalt() {
        SecureRandomNumberGenerator generator = new SecureRandomNumberGenerator();
        String hex = generator.nextBytes(16).toHex();
        return hex;
    }

    public Claims getClaimByToken(String token) {
        try {
            return Jwts.parser()
                    .setSigningKey(SECRET)
                    .parseClaimsJws(token)
                    .getBody();
        }catch (Exception e){
            log.debug("validate is token error ", e);
            return null;
        }
    }
}

