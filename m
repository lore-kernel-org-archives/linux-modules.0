Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776ECC43334
	for <linux-modules@archiver.kernel.org>; Fri,  3 Jun 2022 04:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbiFCEAa (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 3 Jun 2022 00:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiFCEA3 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 3 Jun 2022 00:00:29 -0400
Received: from sonic305-22.consmr.mail.gq1.yahoo.com (sonic305-22.consmr.mail.gq1.yahoo.com [98.137.64.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B030131DC0
        for <linux-modules@vger.kernel.org>; Thu,  2 Jun 2022 21:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1654228826; bh=Q+4vCMpFUCojZIQ0/o7MjNT8dRFe8OnB+GAnYq+oIUA=; h=Date:Subject:From:To:References:In-Reply-To:From:Subject:Reply-To; b=dE7hNSdILTikOWJPTRsT3n+nahChPutLCFfNTNvNcxizdkXt0ZFphYgYtnuiS4eMr2+XpPrsf1+YLAAvNIMrLTu7osPbMdTxf+h/E0wi+q6gpnxZ615l4gpWF4ZMhLudcKNLlsKFZVO0ih2P87a3EXdwWql2a+iHPaH3tpvpuMY=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654228826; bh=ZiiD+oBR3WGtaBmarjz875BbrqqqiTxaenKvpi9C/g9=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=TMqJ4BP17k1Vfx5Z7pL3ak+plYQq5OraIbtHQQc34gmwMtl5vzgObpwP9kwZeW9YsOdvSs1q+xnL25O4MdNMF98csxdVZX5nnmbtt0fOVS9mEtgvBcKWKef1VxvuV7QTaHHn6Hf/e6XBBhNS7uwZOUmnTrqRaJp8zJM36e6EJJTmNpk9jsI8R2Ao45PyW4ULzgUfxRaZKSidqwVsmyckiuq98F1FAPdn7dcF2dIfXouigepsypgLQGQif/ssPS59uABw9Cmfn3gbjsSfPibN/KfDxKlNVzY9ll1ZOfV1c99y21enIiXCL1MQXOSUM5SBoUE9B8uT0PNksHFGJkeMJg==
X-YMail-OSG: yoXPLzEVM1nMaZwGvqM3JtTeQSTWE7yAjhbauKLdw8onhkemoxFgtAyFaQsQPWF
 4ZPhyQuiXBpKJEo0mAqG9P52.ww4r_rNMJp1uaC1iuNaYrMje57grQT6SdsHL5hfXkdHVQYrJjeQ
 Aw5KzT8w2Paj20KxEeA..jJHyoZ6rrkKDEkc.bmw23KR5IA1mcg1vLdRBtUqR0xjT4sHpPtIyO52
 FHG785yBY_OUdi2FqNlnIiJo4GZQ5aOMDvVVo7gjmcM_pgFs.IGyuOpeoSLGT0gbW5iN324AO8HF
 ONPXLJSyg2t34BpPlpsKo6o55yrpZm6rKM32gvjC77q_ZZb78QGwHdgzjU6aar4oSJyHqVK.MkU2
 b4oB1qzK8EUM3xxaGPgQdv966AnCdyIICDAT66ZFOv71pr3m6jaeK5_PWYwCIxzPWsZTm.wZ4zeo
 pkN1rOyYcUaTrsL9opZ24dyH02rI1T6VG_KZP0UdVuE5Le4.LC1HCC9pesxz3gxBdox0LjTGYE2x
 GiSKnkE1gPtQyvwIAAN7faqSfXu3D.fHGISCpaBOp216sQB1XGJZ70c99TrgUEr0X2.p40KtyvHf
 0I1zZrSrDYCyy.BOTEwmm1L9bQeUg00VN.Pv71HrkY4QfuBhnXQDnRWMvZMZcCZOXW2pEIxO_e3p
 cK8W.lXomcYOsU9GFTrzc6y.tzkqmyQnJs3WWO19DFCHxsSB6E27DSGGt5sa16sE.qQUho407yUV
 Oo7tdOlbBn1byCmxYDZGuwlJJZkX1.dAJMqWj.Ts5YjJj.4GKAWkbntUS2AUfMJI2njXDgEydwtG
 FozJj9bYiYchCiEurgEJkNGUaqwo9EDm0zakG9yQYEfzxzPYN7a81hugN57ObF4ynvMYSr.8L_ft
 OBJRTmiE5_5zLIdARxkrSosUu5_.kuWqvok9i5Gsbru40Sq2TuaKCpeTuNLRle4UueX2XNk0eVtF
 HExsVGf5UBKJre0Y2n2U6d.IFUi5kC.eKf1jmms4GT45V8.cBFVpaA0vDSylZcXEP6tmWrlKMCCF
 i6WBGLkUk2XQq3UiDdXhVrFluqlKR1Cz5z16d4w4mhyPrPtdOfYG9EOMG7VV1THkIIDy1k9.Ls6.
 rl6EOFrAwG4BkI_g9AnAVjutyWNwmC4fnxGNwBfiMhM9OlTKwx_oudZM2I2mtQYl8LDOQAZRMmLw
 EtbmtHwO0jlgkm52F0ri8CPfpu3edhenJErH15Q4rri7i9TVs_CPEdRafz09Rc.7IIaaMYdDv44e
 2spNq3dY.G7ZSWpxYGTfFC3472j3Yo32sNTPwS1M6BIL48_5IA0U.oiHebIboOVBnfhqPLosMmzp
 K4W3wg7Ds13NVCfl_f6P1ZJKWeQxa8hPFeMMGJSPyG5M.Bui4ExTkmcUejLgvIg9w2DEC8sWAwUh
 Ckv2KJCCrMoz0hsf83PM93eK2KKlkZCFym.fDfJE1Qje6FbtcPi5UfJUOybJjcTu3JDRp_ahpjnF
 dsR2qTGcSxlLMLWrQnuBgua.e.gvHbAP54moBA2w_pKoe9mRXNdHH0YILmjo0oTd0eSD6VzBMFhh
 twoxhgcl0A6mhAJq0FNFOOfdjCV1gJsPAPqgOTR1BYeDp.muEjwQ.WXX49Ab0FwZWhrL_6Y4ArVf
 iMZkHnwHJ.2t9lWmtptQ7oP.Fu2YVZ3BB7jUcsa1LjzzQTo__dkMfqJ9OlaS5m9QB3ERGpxm3agp
 vtR9GTfY01WutAUVdeFasqiesE5_9ApDrMJ3sa9jzgLeJIbVF2RSl6SrLFJTXtRI9vkCdpkS7kY3
 .WGeyw6U0ZeCvxHwF6WqEgoMBnXHRZZwOTLn2aYdsMJuT2cXzPYUp0X5_VtyDoRGanDN0qtvKD7k
 onZQoThcdTTd5qtz0kg8Mpltx6NgXW7adLr0MduczB_QihY7amaOz20df7qULQqur6av53hKqPcZ
 3aP8bx__QkUgTHiwslqpoYC3yCUdKepIwkMRuiZrhb8oi5swmDbfHhE8j7ZA9tHD4zJ8iGL99J3V
 AIcucVS.gEKaXnQQhkzwF0Eti9hRlp7xZ9jcfMY483Q.OOlzG0pqE7c4agYPdLXT4iTNeHeUWU5b
 NAfkstEynFGrxpizW0YM.ApdTg0CVDujgtJPQO8mlx3DD9X8eiUSla4BpcNhCrtCF0TMvDLd4jbI
 lhp_1peZn4Oa2qoMWjl3Vp403Qk3RZFWYfYKpHYATYkdVlin.Gnc2EQzfyQFLH3vHE2hEluYc4G5
 VxrU5vmh8D7p4ErxE5_vyu0yfg5N8pdSAzHchINv9001sEYYOiRL_HRKO9nk-
X-Sonic-MF: <lesrhorer@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Fri, 3 Jun 2022 04:00:26 +0000
Received: by hermes--canary-production-bf1-856dbf94db-77vvq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e71642b90bbdbc8b8230bccc785ca1a8;
          Fri, 03 Jun 2022 04:00:22 +0000 (UTC)
Message-ID: <a3973eea-510a-7091-4760-378b3ff7b0f1@att.net>
Date:   Thu, 2 Jun 2022 23:00:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Module failure on new install of Debian Bullseye
Content-Language: en-US
From:   Leslie Rhorer <lesrhorer@att.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
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
In-Reply-To: <3643b14f-5240-59b1-d442-09e528d228b3@att.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20225 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

	I may have a valid module ready to load copied from an archive of the 
kernel I am using on this system.  I have placed it in

/lib/modules/5.10.0-13-amd64/kernel/drivers/net/ethernet/bnx2x/

	How do I proceed with attempting to load the driver?  Is there some way 
I can insure the system will still boot with the existing LAN intact? 
It looks like the system may try to eliminate the 1G interface when a 
module for the 10G exists, whether the 10G is working or not.

On 5/30/2022 4:50 AM, Leslie Rhorer wrote:
>      I was able to get the 1G interface on the motherboard up, so now I 
> have LAN connectoivity and apt is working.
> 
>      It is kernel 5.10.0-13-amd64
> 
> On 5/30/2022 1:08 AM, Christophe Leroy wrote:
>>
>>
>> Le 30/05/2022 à 01:46, Leslie Rhorer a écrit :
>>>
>>>       Below is the output of dmesg after removing quite a few of what I
>>> am certain are unrelated lines:
>>>
>>> [    0.000000] Linux version 5.10.0-13-amd64
>>> (debian-kernel@lists.debian.org) (gcc-10 (Debian 10.2.1-6) 10.2.1
>>> 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP Debian
>>> 5.10.106-1 (2022-03-17)
>>
>>> [    1.465675] bnx2x: disagrees about version of symbol module_layout
>>
>>> [   12.075903] bnx2x: disagrees about version of symbol module_layout
>>
>>
>> Those two messages means that you are trying to use modules that were
>> built for a different kernel version.
>>
>> As far as I can see you are using kernel 5.10
>>
>> You have to use bnx2 modules for that exact kernel.
>>
>>
>> Christophe
