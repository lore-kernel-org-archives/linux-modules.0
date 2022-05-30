Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1504C433F5
	for <linux-modules@archiver.kernel.org>; Mon, 30 May 2022 09:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiE3Juq (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 30 May 2022 05:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiE3Jum (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 30 May 2022 05:50:42 -0400
Received: from sonic305-22.consmr.mail.gq1.yahoo.com (sonic305-22.consmr.mail.gq1.yahoo.com [98.137.64.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739E76E8E9
        for <linux-modules@vger.kernel.org>; Mon, 30 May 2022 02:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1653904240; bh=EFEC/oH8juQlnPNOqeAInsqk6DC/fa8WbfZPCkP3o3I=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=1UFSpT1LVuwg/+491t8n+WaGLghQwL8/R7uhAepMVW/eIrobZDliqKnui6u7GbFwQ5UKHhq70Wgm35Xr8nhGTh2yW0PQBqFxVd0/2FAP38tu0SZmux6jLb7rj/+EkdehXxJjMGXsS7/A3Q7jEWY2oivI1hlKuIGFib/wN2mcEEE=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1653904240; bh=L22NCj1b4UiuAW7WcVf4Ho5MKU7JtXDC+IBo/OFhsOn=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=YSl2D/6oAsDHiecvsEj+RfhViPHXRUVSGjTKWjtQy6F9hSaXXU+DYi5Of7b92242aynsgh3iIj1tQxZ9+XtvxrZ27NmijLClASvwR6Zq2EV9UEcn501XOYcogOnTaQJ2+tv3kS5OX2gVmY/h97YZ9V28DuN2KvuVDRi7kkyryHrVsom64SkF/x4oW/LmgvDuQpV/ewEl+y6Ye02jDLcYjDDaEHI2tVphxZGYiTSdlr+kU/f4XDpUySL+Y9oTafKyzuduMHSA6iI2gVdBbw+SrLKfGSljWSV5dNjuxxp9VlyqsS3tJkmtXB13IeW6dT2PYGDxKOvOYyQvGTRTWq/y/w==
X-YMail-OSG: _WfVTcUVM1kn8Mx7ZJbOlY6i2RiVFa6B7CYGdw7y31mKIRJxOgX7JKXh9gW1nn3
 Qj_84Q7KTEZWBP7eaplYaMt3xDpzJtTVDhP58MsfqoU5EQ_o61FKbgNfj_dmiJaviE2ByI.PXBaI
 DVGGtvHPhuuCmf5rpvzNGTtnAi6lPAkMmgJ5X7sVPUgsfLWQ6TpO_TfmLnWxPLcjcvve.aImtLCl
 7rUabQe_23sCaH0LZYCfhygmC99X5.nuycz5s36ceDV02_AVh1FqgPUEBy7rwr8GBUcSUURi73zY
 97mfSV7Dl0c.q9fXci0YduUj2ZAsdKMz_kTfQhcwXr8CEwqR95m3DQjrO7WdY.DIyAGTpx8pROtZ
 CbEHKBFJH6d0UqIgb_6Hh2zW1.R9LmFYHgyGJVzwrUg1aU60dUlFoiiNooRSsMYtSciAJYLK5Mhl
 p.KgTGcBdmEJAjMByRjM41PZUf5F2jU8ZTNb0dTMSIyY3THwbYthNFE1FfBG3A.gHWEMHa95hGXI
 IOgodMHiZHi7CnF5uITJk7c75SvlBLOhsw1T0AX.izH2OVcr0aPLRF6c7ycmE3zYjue15fEbRB.G
 psQ08HITsQ0U8Ed1lnD36CoKY9mvN5tzOP2tx0yWev9wVzSKPzVwqiVxfXRbrrJvpe_02IChQ8M5
 t5ik4AtJNRVAn1IejN65.hLIjBZXjHG08_Ez2nK87JoxG1QggbAIJlwpC6JHctad3z2VCB8LlQy1
 PlytW2f97P4w3A5Urr436UYKQim2vBcml3O1VOOgTlYkjjThMA0l7bZNw9U7z22H7rSzXYGgOUKX
 BEswbMgzzxtLTva7qIqfthMY9AOqotItpb7xj4EE468qmGUreX0t4l_bvtRJBqc5jDq1e5Knj46d
 C9F8w4qSYkHxVmn5a2ZnMyoHsuXYM0U4poVhO35bvVK5gvw2.COAKsDKkEi1tNfNq8M3.wGLdghm
 f8LbuSEK2gh7Tiu32bIhbRYqJdeFkC7QVALbvrDbGVyzCQwPFmSWOkxG4VE7P3ZQo4u_HNUAmHnp
 mZtDBO8li4w37PKh7IZLGwoHRs9bQjAXLQKzvttCHsK_kwXku4gEcIQoMGaiJ.amxXVibXAGS_nn
 M73X13bZur2jj95zSdb8ijsdCvn_UvhpvbxbrRP6yms4w_4vWvkukhHrXFQPZR41qrxmqKm3T1J5
 keCvyj0eVIZ34_uBg9xBXciEdd8z4H3.A0hGshD3a_I_4Wrcvr_4dUNmG03QoBvB5GQuu5R6._46
 27DnI2_eKi9Z5wxdPC7URGm5WdumLAGt8diqMgluCnQ2cCEB5vIktWPfwDYKENwmhafCTOhF2VV.
 2w8Tn.Eeyvsj1wuxfiKIU29TFYaEd1ZgNvSDV3Cg_qoWjzLGbXhSNMyzl_byjPCNSedtlxwa88LO
 ykkHSZ2mXR9rtRbWWDD_P5mp7IJRMGHytUdUgTOlE3I4aUKD25NJ3k6e5alzQIVduVZDh2oirpfR
 WpjfFBm_a_WnjkfVBfLobT.WG8tYTFGFrQWPH_oGgXf95G.0gn5Xks2v8oUn8Rp52z5V5UnBDPdD
 ulSe4pBhBXZNPq17UcIS3I332Nas515AVQxFXYYcCsCmwmRaqV7d2lJupC8DoIg9b9YZDZ0ofjmG
 kTC6TEbxYH4qRyr4YWcGcDQLbuCajL.XhS.r3yjn21xdatiP9OfOOyS.KvgeahwjmIZMLhd3u2WQ
 X9TVCAPt855xR5wQi9y.kUHjdoQCJmgOy2_fGy7iYrY3yqp1bq1J09CWZZNuQWXbST98UAMBAv_N
 rJf2PIpuSnzdmvNJm1yOCMTtt3Vjy5.a_hqL3h5ZFoq4RlHZWq_UzMePhFffbplvm6TZhiOiIvNT
 5m1Khr0zurZ_yHwiNBq9.cT0hdj4mlPQgbI13QQNxbWArDl4IKKf7T5Yn_OTqJSaJTeILmwpaAdB
 diGtE97yQFSN8Ztp.7vl8VsNG6T369xBqGtNF92HrerDtC5fl7Z7FueBwPgMApzRcg7LjnN4kumI
 49GlyTMyaoHUrtmHfYeqDT0IAXZfx2nmTNw0hQ.1D2_m89tfsJ3AndwXGor7ZNTen0Cj_RKBFs4U
 fCC06NN16ADtiuajnaleeqEePW3Wf77JVoWzadQsnYWOFQpQlqa6m2sRGm2TZFjoBFmPo5D9oUjH
 lrrcv3EmbwWQSvyz2pxsUuRn8KJomFw0OoyexSaOmASZ000knYuzG_FjgfmMoNmOY7OqoIgaChbK
 NAlLqhJIW.nAzKQ--
X-Sonic-MF: <lesrhorer@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Mon, 30 May 2022 09:50:40 +0000
Received: by hermes--canary-production-ne1-799d7bd497-7lvgk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 34a288aebce45ff4d5722f51bb565f1d;
          Mon, 30 May 2022 09:50:39 +0000 (UTC)
Message-ID: <3643b14f-5240-59b1-d442-09e528d228b3@att.net>
Date:   Mon, 30 May 2022 04:50:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Module failure on new install of Debian Bullseye
Content-Language: en-US
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
From:   Leslie Rhorer <lesrhorer@att.net>
In-Reply-To: <13529cf4-a00d-5e59-2e1c-cb1daf24bf71@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20225 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

	I was able to get the 1G interface on the motherboard up, so now I have 
LAN connectoivity and apt is working.

	It is kernel 5.10.0-13-amd64

On 5/30/2022 1:08 AM, Christophe Leroy wrote:
> 
> 
> Le 30/05/2022 à 01:46, Leslie Rhorer a écrit :
>>
>>       Below is the output of dmesg after removing quite a few of what I
>> am certain are unrelated lines:
>>
>> [    0.000000] Linux version 5.10.0-13-amd64
>> (debian-kernel@lists.debian.org) (gcc-10 (Debian 10.2.1-6) 10.2.1
>> 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP Debian
>> 5.10.106-1 (2022-03-17)
> 
>> [    1.465675] bnx2x: disagrees about version of symbol module_layout
> 
>> [   12.075903] bnx2x: disagrees about version of symbol module_layout
> 
> 
> Those two messages means that you are trying to use modules that were
> built for a different kernel version.
> 
> As far as I can see you are using kernel 5.10
> 
> You have to use bnx2 modules for that exact kernel.
> 
> 
> Christophe
