package com.example.demo.dto

import java.io.Serializable
import java.util.*
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Id

@Entity
data class CommentWithTreePath(
    @Column(name = "comment_id")
    @Id
    var commentId: Long? = null,

    @Column(name = "bug_id")
    var bugId: Long? = null,

    @Column(name = "comment_date")
    var commentDate: Date? = null,

    @Column(name = "comment")
    var comment: String? = null,

    @Column(name = "author")
    var author: Long? = null,

    @Column(name = "ancestor")
    var ancestor: Long? = null,

    @Column(name = "descendant")
    var descendant: String? = null,

    @Column(name = "path_length")
    var pathLength: Long? = null
): Serializable
