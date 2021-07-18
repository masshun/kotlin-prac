package com.example.demo.entity

import com.fasterxml.jackson.annotation.JsonIdentityInfo
import com.fasterxml.jackson.annotation.ObjectIdGenerators
import java.io.Serializable
import java.util.*
import javax.persistence.*

@Entity
@Table(name = "m_bugs")
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator::class, property = "bugId", scope = Bug::class)
data class Bug (

    @Id
    @SequenceGenerator(name = "bugSeq", sequenceName = "bug_id_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "bugSeq")
    @Column(name = "bug_id")
    var bugId: Long? = null,

    @Column(name = "date_reported")
    @Temporal(TemporalType.TIMESTAMP)
    var dateReported: Date? = null,

    @Column(name = "summary")
    var description: String? = null,

    @Column(name = "resolution")
    var resolution: String? = null,

    @Column(name = "status")
    var status: String? = null,

    @Column(name = "priority")
    var priority: String? = null,

    @Column(name = "hours")
    var hours: Int? = null,

    @Column(name = "reported_by")
    var reportedBy: Long? = null,

    @Column(name = "assigned_to")
    var assignedTo: Long? = null,

    @Column(name = "verified_by")
    var verifiedBy: Long? = null,

) : Serializable
