package com.kh.pot.home.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.pot.recipe.model.vo.Recipe;

@Repository
public class MainDaoImpl implements MainDao{

	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<Recipe> selectRecipe(int number) {
		return sqlSession.selectList("home.selectRecipe", number);
	}

	@Override
	public List<Recipe> selectShowHome() {

		return sqlSession.selectList("home.selectShowHome");
	}
}
