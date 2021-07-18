package com.example.demo.controller

import com.example.demo.entity.Comment
import com.example.demo.service.CommentService
import org.slf4j.LoggerFactory
import org.springframework.web.bind.annotation.*
import java.lang.Exception

@RestController
@RequestMapping("/comment")
class CommentController(
    val commentService: CommentService
) {

    @GetMapping("")
    fun findAll(): Any {
        return try {
            commentService.findAll()
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    @GetMapping("{ancestor}/{descendantFirst}/{descendantLast}")
    fun findWithSameAncestor(
        @PathVariable("ancestor") ancestor: Long,
        @PathVariable("descendantFirst") descendantFirst: Long?,
        @PathVariable("descendantLast") descendantLast: Long?
    ): Any {
        return try {
            commentService.findWithSameAncestor(ancestor, descendantFirst, descendantLast)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    @PostMapping("")
    fun save(
        @RequestBody comment: Comment,
        @RequestParam("lastParentId") lastParentId: Long?
    ) {
        return try {
            println("comment: " + comment)
            commentService.save(comment, lastParentId)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}
