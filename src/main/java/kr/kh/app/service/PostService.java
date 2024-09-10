package kr.kh.app.service;

import java.util.List;

import kr.kh.app.model.vo.CommunityVO;
import kr.kh.app.model.vo.MemberVO;
import kr.kh.app.model.vo.PostVO;
import kr.kh.app.pagination.Criteria;
import kr.kh.app.pagination.PageMaker;

public interface PostService {

	List<CommunityVO> getCommunityList();

	CommunityVO getCommunity(String num);

	List<PostVO> getPostList(Criteria cri);

	PageMaker getPostPageMaker(Criteria cri);

	boolean insertPost(PostVO post);

	void updatePostView(String po_num);

	PostVO getPost(String po_num);

	boolean updatePost(PostVO post, MemberVO user);

	int deletePost(String po_num, MemberVO user);

}