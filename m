Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1643C43334
	for <linux-modules@archiver.kernel.org>; Sat,  4 Jun 2022 06:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiFDGPE (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 4 Jun 2022 02:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiFDGPD (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sat, 4 Jun 2022 02:15:03 -0400
Received: from sonic305-22.consmr.mail.gq1.yahoo.com (sonic305-22.consmr.mail.gq1.yahoo.com [98.137.64.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890B910FDB
        for <linux-modules@vger.kernel.org>; Fri,  3 Jun 2022 23:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1654323301; bh=xn/Ss34U/FxRX1HnF630xMUilOY/cASY1TGvYQ9+rIw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=L+rEyi7t5bdTjCgo9UdUcKiZIGtrZO4j86tN4EBs4EtsQ3LuIyiGFhS/MBnsoa6F3hfhjEuThRTZJBz+ejWmcm+UB8IegXe5Vaws0CWPTZ1vewNd+QznLi+psw6RrEpHv6lKzYRT6kVJf/EmLKMLoGpDBP+6SJrriXqnsc/E95w=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654323301; bh=sduXNeZeycJ10Zu9IlS+/x9uH0hSK4t9cMDU40hsS6u=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=UIBXr54HHdao8LoILrH9zMfSjkEeu8133OyBI8hcK7g+3o+hLhdo+rhYvOd2BzjTC2O9qc07hqeikjIkK5yYi8oOrK9kujO6h7BwfHSVF8fhDJLZ9MR87TkTOUw4vshuhf1DT4H3TTKGrS4hK1fojtUXwWuJTxrclZoIbLxELjZmtRW50PhN8usnY2453UyvSn7WnESvSBrbmhXUQJmrMq3LI0UcrBX4mb0DEdtDdn4j3yGHUjnkvZUttX+RNz27IUJtzc5d6rgcnwKXHFofHIsT6KIdfHqWhqPlLUD+VwLwQ4gbr4rSRlwSKL08AKlYJ+2GAUzE4gI4wR/i41kulw==
X-YMail-OSG: fodIpjIVM1kPQCM.FKQ6uhqdZzDI8JYAHqJzJxtseOM0eOzpNGQZOgGBFoFBQG3
 Hf0p9FRYYWeiH7YujujkgC1gKfOaZOEMM1wZGatfNH2Q2FvWMqWdS6SLcr7.CeoGB2rjwQ9fjduL
 0CKwZ_CQiUYjPZTPOgSUG35Yl0lUwWRwSYPBHyN6GG_kBrvo8pXbPVJ7rhWj6BUCQL6p5o7jPSqJ
 aImxzj_Mv2bpdZ9O_VToLHxECKcg7hjVouS6OKPrskuQWrj5l96SV75hh8.o3TsmTCmeCkGXEkpv
 BpjmrsKZWm4ylrVOltlTHXH58XeydxJ0AL67lxIKMe_WprbbNYugpy7eX4OxFOudQQYwkPEy9PWC
 LGd_E_c1QP72s7RrdQ0Bw5zLtR3jOXmNmgP_q1e38tBqmv9AOe_8LWpAlNvh5DiD0fofAVCQgqVY
 siijpmBTPx4bLqStmhFUjxKePp0j8UP1ZpXqCgR9XGgrIUEO7cLP338APXi57OWHGdUFC1fOzOMi
 Es3oxVrD8X8QVepDFAYgHiaTFtXfk9DZT9Nf22ZYU1DPnBidtU23rNTaSBUPr95px.OzfA84vwi7
 2fo2bXKV8fHY5f0TEUBuivukMyXRHjpY0fuJqKMpivtHVUy6.havrkDKDym2fVReTRoU2xcQEasa
 6I7IT.YMoAop5XyuzMlHcxved7oDOT5h_l3TQbXMqu9EI67PweE0oPNzzJa7Ls09v9clXpCTh8tl
 CWiCDHB9LdUB3xo4dtljpM2.J08ZDzhC8mTsrvObSB6r7rjGwTHfAsKcQ_OfNY6.pPKHWPksEa4_
 vx_bUbyNxQprAIyxB.Y59lBtVRKFAWCbnT8BL5Kap26tGtUGUtjLNv95oFPuICKAd3P_PoJLAskW
 LzF3i7Q5w6vNwSTMESOh92VuFih2pr36Nj_zTcdxE15etJr9_7JNThAYAdLU.Ac3f9L7MqMdiTcp
 oT7Jp5TiyRGBFlm_x9kldlDvkXzYCvm1j4rWfgA1F3T.kfwnD94possRWeB8D444aF52vU4JKj1V
 4bjX2g_IePWc.HgY_YzhX2q6gww1zz7JltSPphFbPZdAVf4JinxoRDmyX0s_j2z8LIdavU3BshzT
 Vp071hv0eHQwI1Gwt9kCDlvdbhzEyqxEEjLD9vyUrOIIURAFkr3twtgA6TCncjsourKXGZj1E3zh
 kcdPV33oRAQNKkRblsjX337kWBeDYrntiQIDk_PZZxhJxwnZWwv0sf4tawfFo8YZ82TWGFuXCjGV
 gQW4frOh62eEIktgeUEZOexb23pbbBs_aWKPu0e1WANZFBcVfojSorXTgKV1xMEr8l0uKbvG8jxZ
 PM21cXKN_dtECR6L8BvfBq07OjPSI5j6byzjRw3YqHEuJNGlLuLlwUawCxgAqVQ146BU8oGQ21.6
 5KAo_M5PLFPxMfbn7VnWt3uzBZyKGHkyu9V13d6kk5nlifkvugg0BnaF3BZBV2XDAmxReKL0ySoo
 VS.rfU9i8s0.fI_w2XL_lwNUxndnC7adWAuYqd9lzPfDPqiAogU7LdHhMaSC.hxQ4hwXRDB25Y9W
 OlcM_KQHJLxnw2j7Kcc7RqzyBi6Izz60yX4mSu4B9kqr2qivaLBrS2M1XwYgR8mmqaIyAC9SEP.z
 gDtzU7kpFgw_T9.T0emczEffF3BjpjKDAC7IRF2Q35ISpXemSEDJXGZGahCUwIRsQdj3WtvKRszV
 iENDkgaql.i3qcJ4cQjYQsKsXuf6TOg0sKo014MC8_HbtUMW7d2uCR3AbtWIP1lA4ZcH_Gf4Lfuv
 SuWmPFkNNwFfIi7I42GmXPEWejwDsrZVZSKCmSDd2TFdHljusv74cjEj_9rOp1105BfPg5Y8bc88
 K2aD53soLY6ktY1WUFARwdwZZVDU_tlM2H6y18l3Qj.dQMJ8Bn9ItgkcJPV5a17r5TiO.jDYt1.c
 ByLQgc5QJvG8EMoxjTMHsmaOnw_joQoz.UshpXIjSAjiR19gZzprR3eC8jiJPf4wsVtQiWP9h1Iy
 6MxGqsJ28Ks9d5iortFRt6I6B9IRo2A3SBGbQoeAv.G7ClAcB_SLMQF_ICvHcyiUIntUJ11ObSEU
 X7yhDgRk70i3BZRDnwQeUo_pN63jXr_m1Jp5z_rzRLHfVJHNRAJHqnNMj30_T6XPunb_m5QJ8_6G
 DD3jae9lLOneUGUOVa4YFfqHCSJ4g_cZw9aAbLjeil0Uyvl_gM_ke3sk_4vi9Aix_Zl4XO1s6qpt
 nWdJCZVjHZd1rrEDZAB4GcrN4C6uslBs61y.jA1JDn760nwqyUpi7fVBNw8HH
X-Sonic-MF: <lesrhorer@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Sat, 4 Jun 2022 06:15:01 +0000
Received: by hermes--canary-production-bf1-856dbf94db-77vvq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6e34992c449647bbaf54db9f24739c8b;
          Sat, 04 Jun 2022 06:14:59 +0000 (UTC)
Message-ID: <bcc95958-832b-daa9-62c5-a5cdd634cba4@att.net>
Date:   Sat, 4 Jun 2022 01:14:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Module failure on new install of Debian Bullseye
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
References: <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0.ref@att.net>
 <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0@att.net>
 <7999b7b4-3b58-a9c4-4756-445e54404f0f@csgroup.eu>
 <ba2fb3ff-22dd-d68e-fa99-02de39240f20@infradead.org>
 <3b8f2ed6-11fd-b5a7-5442-7cac90348514@att.net>
 <8de4e4b7-f741-eb4d-9e11-9b23ba65c21a@att.net>
 <13529cf4-a00d-5e59-2e1c-cb1daf24bf71@csgroup.eu>
 <3643b14f-5240-59b1-d442-09e528d228b3@att.net>
 <a3973eea-510a-7091-4760-378b3ff7b0f1@att.net>
 <YpokHQKUPCG4L2Ar@bombadil.infradead.org>
From:   Leslie Rhorer <lesrhorer@att.net>
In-Reply-To: <YpokHQKUPCG4L2Ar@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20225 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>



On 6/3/2022 10:09 AM, Luis Chamberlain wrote:
> On Thu, Jun 02, 2022 at 11:00:00PM -0500, Leslie Rhorer wrote:
>> 	I may have a valid module ready to load copied from an archive of the
>> kernel I am using on this system.  I have placed it in
> 
> Huh? You should not be copying around modules loosely from other
> kernels.

	I know that.  This not from "another" kernel.  It is from an archive of 
the same kernel.  IOW, I have another machine running a 5.10.0-15-amd64 
kernel that was upgraded from 5.10.0-13-amd64, and still has the 0-13 
bnx2x driver still in the archives.

>> /lib/modules/5.10.0-13-amd64/kernel/drivers/net/ethernet/bnx2x/
>>
>> 	How do I proceed with attempting to load the driver?  Is there some way I
>> can insure the system will still boot with the existing LAN intact? It looks
>> like the system may try to eliminate the 1G interface when a module for the
>> 10G exists, whether the 10G is working or not.
> 
> Sounds like you want to engage with the bnx2x developers and report
> whatever it is you are seeing.

	I have been trying (and apparently so have others) with no success.

> But note, you should probably try a more recent kernel.

	The same problem exists there.  Indeed, I need to wipe the other server 
and reload its OS, but I will run into precisely the same issue, since 
it is the 5.10.0-13-amd64 that is on the installation DVD.  I am 
physically disabled, so having to reconfigure hardware for a reinstall 
is a real problem.

	I suppose I could upgrade the new server to 5.10.0-15-amd64, but then I 
still need to install the 5.10.0-15-amd64 driver.  No matter what, I 
need to insert the module.  When I look up the man for insmod, it says, 
"don't use insmod, let the kernel do it", or words to that effect.  So 
now, what?  One way or anotehr, I need to get this system working, and 
then I need to do the same with the other system.
