package com.klx.samsung.service;

import com.klx.samsung.dao.ProductMapper;
import com.klx.samsung.domain.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {
    @Autowired
    private ProductMapper productMapper;

    /**
     * 根据id查询商品
     *
     * @param ids id列表
     * @return 返回商品纪录
     */
    public List<Product> getProductsWithIds(List<Integer> ids) {
        return productMapper.getProductsWithIds(ids);
    }

    /**
     * 通过类别查询产品
     *
     * @param type 产品类型
     * @return 返回产品纪录
     */
    public List<Product> getProductByType(String type) {
        return productMapper.getProductByType(type);
    }

    /**
     * 通过网络类型查询产品
     *
     * @param network 网络类型
     * @return 返回产品纪录
     */
    public List<Product> getProductByNetwork(String network) {
        return productMapper.getProductByNetwork(network);
    }


    /**
     * 添加产品
     *
     * @param product 产品
     * @return 返回数据库执行结果
     */
    public int addProduct(Product product) {
        return productMapper.addProduct(product);
    }

    /**
     * 根据id删除产品
     * @param pid 产品id
     * @return 返回数据库执行结果
     */
    public int deleteProduct(Integer pid){
        return productMapper.deleteProduct(pid);
    }

    /**
     * 更新产品
     * @param product 产品
     * @return 返回数据库执行结果
     */
    public int updateProduct(Product product){
        return productMapper.updateProduct(product);
    }

    /**
     * 多条件查询
     * @param product 产品属性
     * @return 查询结果
     */
    public List<Product> getProductByMore(Product product){
        return productMapper.getProductByMore(product);
    }

}
