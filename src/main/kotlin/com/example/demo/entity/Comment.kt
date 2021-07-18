package com.example.demo.entity

import com.fasterxml.jackson.annotation.JsonIdentityInfo
import com.fasterxml.jackson.annotation.ObjectIdGenerators
import java.io.Serializable
import java.util.*
import javax.persistence.*

@Entity
@Table(name = "c_comments")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "commentId", scope = Comment::class)
data class Comment (

    @Id
    @SequenceGenerator(name = "commentSeq", sequenceName = "comment_id_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "commentSeq")
    @Column(name = "comment_id")
    var commentId: Long? = null,

    @Column(name = "bug_id")
    var bugId: Long? = null,

    @Column(name = "comment_date")
    @Temporal(TemporalType.TIMESTAMP)
    var commentDate: Date? = null,

    @Column(name = "comment")
    var comment: String? = null,

    @Column(name = "author")
    var author: Long? = null

) : Serializable
