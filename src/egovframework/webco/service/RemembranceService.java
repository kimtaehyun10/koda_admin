package egovframework.webco.service;

import java.util.List;
import java.util.Map;

public interface RemembranceService {

	List<Map<String, Object>> memberList(Map<String, Object> commandMap);

	int memberListTotCnt(Map<String, Object> commandMap);

	List<Map<String, Object>> letterStoryList(Map<String, Object> commandMap);

	int letterStoryListTotCnt(Map<String, Object> commandMap);

	Map<String, Object> selectedMember(Map<String, Object> commandMap);

	void memberUpdateEnd(Map<String, Object> commandMap);

	void memberDeleteEnd(Map<String, Object> commandMap);

	void memberWriteEnd(Map<String, Object> commandMap);

	Map<String, Object> selectedLetterStory(Map<String, Object> commandMap);

	void letterStoryUpdateEnd(Map<String, Object> commandMap);

	void letterStoryDeleteEnd(Map<String, Object> commandMap);

	void letterStoryWriteEnd(Map<String, Object> commandMap);

	List<Map<String, Object>> letterStoryComment(Map<String, Object> commandMap);

	void letterStoryCommentUpdateEnd(Map<String, Object> commandMap);

	void letterStoryCommentWriteEnd(Map<String, Object> commandMap);

	void letterStoryCommentDeleteEnd(Map<String, Object> commandMap);

	int commentEndIdx();

	int donateEndIdx();

}
