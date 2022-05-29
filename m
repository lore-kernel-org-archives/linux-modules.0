Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC22C433EF
	for <linux-modules@archiver.kernel.org>; Sun, 29 May 2022 23:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiE2Xm6 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 29 May 2022 19:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiE2Xm5 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 29 May 2022 19:42:57 -0400
Received: from sonic306-24.consmr.mail.gq1.yahoo.com (sonic306-24.consmr.mail.gq1.yahoo.com [98.137.68.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976BC3F33A
        for <linux-modules@vger.kernel.org>; Sun, 29 May 2022 16:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1653867776; bh=JGoT/dLVqRgZvTNxVbGQbelhV5QYb8uOewkl69lnjyU=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=cFTob/rCInNV18XckNWIdjA+73UUvch/K2u1H4s0NWbn9upDenn8MOS+oC2Hu0ntVZmiz9ohfHTwuqJKXT6HDVQFaViymN5RHGbUlyhpWO0VX3ciA79I9ncmSNgvNlAkURR5QljEtir04GvzcamRv/RyIks0eq2gmGLoASQg4kM=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653867776; bh=cpCsiB3vZISTbKd36w4W4y0WvAdk9NzYem9jeBM2rvZ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=VstyICQ5rxFpOxPkwCipoEx1iFgzBo8mZzlGkz8kMqhyWviHQkaArlJyqM3NvZHvGH6ocC0GYNub0z1vwHLOSNNWfZWFOM7VNXmP1l2pLk/hELViCKOEmZ6SwmlBcus+9LTuMKYF84469D8rbel6uj0DfdEZNrUk0I6ieefe2k7WP1//TGh7za5Omt4dc4N66nrxzNvlRjRQqGPPzrGa1zMUA37qR82fcl4wbAj7eWuZvdr7ro2LKB4Eu3kaRBNyXOeORbr4FziMt28sTFCILooUBUY1hWjG2V8JUpdhTiqjxne+qjjAd/ilrX0qITBZwZONZvue2MJRAjA/1qe6iA==
X-YMail-OSG: ZUagYbwVM1lRG_nBz6Y_eG548TurxtUg.X9f4yoyB8bMqoMKW8Jro2PQJzjKwwp
 w.wcDszNN9EVVd9VExB9_HQ_qPMUhqNRKa3DXJQDH4vla2.wzp2FvB3BwNSOYisEfOe8UmemmH03
 sRLISjOprxnvI887DqDq.LvkeOFK8MLAlajTkB6wObHqcURjUiNMNmg33m4FuEhucigJolCehJNm
 xUgFn9WqKoMC.YntbPFEPumlm_6F0lZFXaoFNwTeNtpHAhYax3EbgHst20EtZkhSzu6nppL_BDR5
 nLgxo43T109ThLWsR0rVksIqZ_1_pO8Xlavy0lL9NOM43bflrExcvRbx9SXDcL8TH5wml1ArBvFU
 xL8yWmOrhVSMOfEpYgCVQwMdOlfXTh4qTak85ooHDQWpWfsTdEnF4OCXns8ZuFA1vywCl0IB5ZCI
 tGTJhWMXOEM8T93vffp4.IZihoRx5_TrIZUO3y7nX3kyGPgcyrxj7bd83a6SvdSda1VU3d6ZEBAp
 uDgYWgIjab0.lp3q.6M8IWCc.jS8ZoiipDFnNjsE9c6Y.bqn5I0kLN20uB9imGNlghX8yZxgIExk
 rY6TfDDERugwaDdGSXKshp5qHWzrY.OuF7FnMR6sJPnPJdV0NkQcamahP0wKu3m6VRJmYcBhzSFp
 67R7rDUjpIxMcHzlxFROyjuEsywazI.eRkSTiO3jgg9ej8d76lt_OT5GEbUJzQYyY4R1QuSP55Ml
 3APYyN5pzLC2uwOh4EASxo8CkwBZcwOXVSKj_yrJUQ3DngLYVH.qlQlL65rAkJDhvYJbu3Fmpxfe
 FdIKsvSXc5nKLKhBvx8CrQ6M3xyOpBAlfTDjiGqAJUVI5IgdwRl31FROLN1bbe.ai0lsIj4Xwo92
 ae47sZFudFK6AUT3mvb9rWR9.kHJEpsUSo8Ivug6V1E6VKJl.cqGI1qoE7lncVjIDsuZ2j6HeD77
 BX7YkAWGBqiBxPO2zD_FMhdLHGnH7Zcm08SjYtyM4vBW0v6ahSkWBc1xi58Oy.BUJZHvoX5sg74T
 GJFO8h5UfDLS2DBtgqZTZqUHPcTRbdzB5jIBWeeqfV.7xZf1uK2kQg7d0Xy2tLhq4UL83GT3ltGW
 MrVbn8bGwF4GSgK79PwkTElsO8y9VYaML3Y3cmccWXo1S0EVI1q9ouk.HL5qoTI_lmA9MpKdOeyg
 Ok3l3WZAqIg8e0029fdm47s8jHk0axjkwQm2Yk11VO4PWhRteQ2y_om7F2PTd97RjuuYArZEek1b
 2u8Z150pBOjru0Q6u3KF3FRf0Nab5yqTAACPoDApemN93njmVjyx.5ZeMrwA.MuQSPyg6J1qOh4F
 k77jv98U2yk1c.JwfBpGfZoUBP9rxFQtym5OdbbeLQVVA2me1FgA9kzTUANehTmQP1f0SvofVJDZ
 oNjrl6PI.B5t1aTr_kWWCuiV4lH9WC0CTVeqwium0SEG.78xw0qmueDgvlDwN0ie2E8z1pgUwcCU
 SwHKNCi8S2ArF5Uqqamo8bzw6s__i.RKjVKwZKD_N3A5PPEclidCBbOpgpBhS1GQ_YXiAOHtQaBO
 VPqqeasGSSUIF6KFfhWlr6eOJ7s_llMRTbQdxdLA7xzGrS3CvGWFlC8E5LZmPvxaT4zTRpm5KgdI
 dmV4KiS5Ij_4Mvep_06IOc.ltvxQ27BFjLk9pW0k7ckMpJwa43WZT0L3XcoNhDtJmNeB0L4KanXk
 wXV8hYk2G7YFGaYZp8k72kgRy_BZBy5sqLa3apoLjHGC_d_hMQszrF1X7BRZ4dW55PbBuDL47RLW
 C029YSOCjsfTWUKgu3OFw7GwArg.gIo_o0t66hUZw1tKlI35y5LR6_t.lA4Flp5l6Y3fDZVZutTb
 gEWY9c72ywS0Tw4ItsMX9Qa63Ob8SjF.yANyMeFU5U4TCyNr5n2WOwTAHVqKqkfLBR5KJh2RFaUd
 Nhb6NySIeeRnB8qc4sz7KifztMYGzVAZwR7WMo3_ZYcTW5iB7OdqawWPKOeWa5NzRBp.F34AoEOC
 knqWR43Y1.UjMvkP_k3hJrg3EnE2XOvsqpozkdsvsSS4yiDDifImjfyEFk2PwCKV__WWAIbkEh.O
 l3qBDpIYHXSYhaOhOuj.EfX5_RyjU228tA6.QrFCxToiGmM0wnFT7e3LHZUDVOcZhHxdJEEKV2zo
 n8lfDLk2R_WPtEX9NO3HnYVAyejqY2SGmzqSLjnXujLz0IxXGCl5AJzywdECHLXUaTWq_lQ9IxI3
 _4q3YWYbnkLqc.IRJMlWpCOnytfnYDYnDY0Og5ovvCE73.RrXNKSa9abNMsEouVnbcAg-
X-Sonic-MF: <lesrhorer@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Sun, 29 May 2022 23:42:56 +0000
Received: by hermes--canary-production-ne1-799d7bd497-7lvgk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ac58646b807d8fc5508f36861b3220a0;
          Sun, 29 May 2022 23:42:51 +0000 (UTC)
Message-ID: <2d91a832-0648-c88a-c763-d5c5f30a8cd6@att.net>
Date:   Sun, 29 May 2022 18:42:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Modules list
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
References: <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0.ref@att.net>
 <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0@att.net>
 <7999b7b4-3b58-a9c4-4756-445e54404f0f@csgroup.eu>
 <ba2fb3ff-22dd-d68e-fa99-02de39240f20@infradead.org>
From:   Leslie Rhorer <lesrhorer@att.net>
In-Reply-To: <ba2fb3ff-22dd-d68e-fa99-02de39240f20@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20225 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

	OK, well the message, as I said, was bounced.  It's rather urgent.  Is 
there a limit on the size of the message?  Even though I removed much of 
the content, the message was still rather large, since it contained a 
filtered output of dmesg.  I will try splitting t up.  Can attachments 
be made in the list?  Zipping the contents of the dmesg output will cut 
the size greatly.  I will also try zipping the dmesg text.

On 5/29/2022 10:41 AM, Randy Dunlap wrote:
> 
> 
> On 5/29/22 08:21, Christophe Leroy wrote:
>> Hi,
>>
>> Le 29/05/2022 à 13:35, Leslie Rhorer a écrit :
>>>          I sent a subscription to the linux-modules list which seemed to be
>>> successful, but when I sent a message, it bounced.  I sent the message
>>> to linux-modules@vger.kernel.org.  Did I do something wrong?
>>
>> Obviously you did it right as I got your message through the modules
>> list (I'm not subscribed to linux-kernel list).
>>
>> Christophe
> 
> and you can see it in the lore archives:
> 
> https://lore.kernel.org/linux-modules/7999b7b4-3b58-a9c4-4756-445e54404f0f@csgroup.eu/T/#t
> 
