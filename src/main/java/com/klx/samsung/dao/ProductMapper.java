package com.klx.samsung.dao;

import com.klx.samsung.domain.Product;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductMapper {

    /**
     * 根据id列表查询
     *
     * @return 返回所有产品纪录
     */
    List<Product> getProductsWithIds(@Param("ids") List<Integer> ids);

    /**
     * 根据类别查询产品
     *
     * @param type 产品类别
     * @return 返回产品纪录
     */
    List<Product> getProductByType(String type);

    /**
     * 根据网络类型查询产品
     *
     * @param network 网络类型
     * @return 返回产品纪录
     */
    List<Product> getProductByNetwork(String network);

    /**
     * 添加产品
     *
     * @return 产品添加成功返回true
     */
    int addProduct(Product product);

    /**
     * 删除产品
     *
     * @param pid 产品id
     * @return 返回数据库执行结果
     */
    int deleteProduct(@Param("id") Integer pid);

    /**
     * 更新产品
     *
     * @param product 产品对象
     * @return 返回true代表更新成功
     */
    int updateProduct(Product product);

}
