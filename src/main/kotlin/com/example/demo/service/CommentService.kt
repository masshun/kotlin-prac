package com.example.demo.service

import com.example.demo.dto.CommentWithTreePath
import com.example.demo.entity.Comment
import com.example.demo.repository.CommentRepository
import org.springframework.stereotype.Service
import javax.persistence.EntityManager
import javax.transaction.Transactional

@Service
class CommentService(
    val entityManager: EntityManager,
    val commentRepository: CommentRepository
) {

    fun findAll(): Any {
        val sql = """
            SELECT * FROM c_comments
        """.trimIndent()
        val query = entityManager.createNativeQuery(sql, Comment::class.java)
        return query.resultList as List<Comment>
    }

    fun findWithSameAncestor(ancestor: Long, descendantFirst: Long?, descendantLast: Long?): Any {
        val sql = """
            SELECT t.*, c.*
            FROM c_comments c
            INNER JOIN treepaths t ON c.comment_id = t.descendant
            WHERE t.ancestor = :ancestor
            AND t.path_length BETWEEN :first AND :last
        """.trimIndent()
        val query = entityManager.createNativeQuery(sql, CommentWithTreePath::class.java)
        query.setParameter("ancestor", ancestor)
        query.setParameter("first", descendantFirst ?: 0)
        query.setParameter("last", descendantLast ?: 0)
        return query.resultList as List<CommentWithTreePath>
    }

    @Transactional(rollbackOn = [Throwable::class])
    fun save(comment: Comment, lastParentId: Long?) {
        val savedComment = commentRepository.save(comment)

    }

}
