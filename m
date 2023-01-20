Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2B0C25B4E
	for <linux-modules@archiver.kernel.org>; Fri, 20 Jan 2023 16:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjATQQZ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 20 Jan 2023 11:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjATQQY (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 20 Jan 2023 11:16:24 -0500
Received: from esa.hc4604-54.iphmx.com (esa.hc4604-54.iphmx.com [207.54.93.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448C37CCF6
        for <linux-modules@vger.kernel.org>; Fri, 20 Jan 2023 08:16:23 -0800 (PST)
X-IPAS-Result: =?us-ascii?q?A2GmAQCCvcpjAIilh5YNTYEJCYFGgzSBWIRPkHEuA51Rg?=
 =?us-ascii?q?Sw+BgkBAQEPPQcEAQEDBIIMgXOBAAKFHyY3Bg4BAhkBAQEFAQEBAQEBBgIBA?=
 =?us-ascii?q?QEBAgwBOlKFLzmCRSIZZFM1AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAg1SM?=
 =?us-ascii?q?UcBAQECASMPAQU6BwULCw4MAh8HAgJXBg0IAQGCegGCfzafXAGKIHqBMoEBn?=
 =?us-ascii?q?0MJgW4GgRQtkSBDgg2BPAwDgj0HMD6CSxcCAgEXgSyDcoJnBIIuAZBih3cKg?=
 =?us-ascii?q?Tt8gScOgUiBGgIJAhNUJQQOAxkrHUACAQs7Mgo/ATUJAgtKKxMHGweBCCooF?=
 =?us-ascii?q?QMEBAMCBhMDIgINKDEUBCkTDScmaQkCAyFhBQMDBCgtCT8HFREkPAdWNwEFA?=
 =?us-ascii?q?g8fNwYDCQMCH09aFgIuERMFAwsVKkcECDYFBhs2EgIIDxIPBiZDDkIhFjQTB?=
 =?us-ascii?q?lwBHA0LDhEDUDiBFQQvgWcGKSicc4MaBDMIFwp6gS0ykiWRAIEwnheDeotbl?=
 =?us-ascii?q?HkGDwQuqSqXS41OmkGBeIIAMxoIHRODI1EojiwWFYhPhWpXCTACBwEKAQEDC?=
 =?us-ascii?q?YwjAQE?=
IronPort-PHdr: A9a23:Ss4x5h/dQ/fka/9uWXa7ngc9DxPPW53KNwIYoqAql6hJOvz6uci4Y
 QqGvK8m3ACBdL6YwswHotKei7rnV20E7MTJm1E5W7sIaSU4j94LlRcrGs+PBB6zBvfraysnA
 JYKDwc9rDm0PkdPBcnxeUDZrGGs4j4OABX/Mhd+KvjoFoLIgMm7yeC/94fObwlVmjaxbrB/I
 RerpgjNq8cahpdvJak2xhbVuHVDZv5YxXlvJVKdnhb84tm/8Zt++ClOuPwv6tBNX7zic6s3U
 bJXAjImM3so5MLwrhnMURGP5noHXWoIlBdDHhXI4wv7Xpf1tSv6q/Z91SyHNsD4Ubw4RTKv5
 LptRRT1iikIKiQ5/XnUhMJ+g61UrhKvqQFhzYPKboGVM/hxcb/Sc94BWWpMXdxcWzBdDo6yb
 YYCCfcKM+ZCr4n6olsDtQWzBQm2C+Pp1zBIgmH53bcn2Oo8FgHJxxIvH9YXvHrJq9X1LrkdU
 eauzKnPyzXIcvRb1iv96IfSdBAuvPWMUqxqccfKxkkgCQXFjlKVqYP7JT+azP4Ns2ma7upnU
 +KgkXQrpB9srTiy38ohjJTCiY0JxF7e7yp53Jo1KsOiSE59edOqH4ZcuiGHOodrQs0vQm9lt
 To6xLAYpJK2eDYHxIg5yhPDd/GKfZWE7g/iWeuRITl1gGxodK+/iRqv/katyOLyW8+p21hEq
 SpFl8PDtnEL1xHL6ciIVOF9/kG/1jaLzQzT7ftEIU8smavVKp4hwb8wloINvkveHy/5gl/6j
 KiMdkUr/OWj9ufpYq3+q5OBN4J4lhvyPrkgl8G/G+g0LwkDUmiB9eih2rDu/Ev0S6hQgPIsi
 KnWqpXaKNwepq6+HgBazJ4u6w26Dze6yNQYmmQHLE5ddBKHkYfpP1bOLej8Avuin1igiipny
 v7FM7H7AJjAKmLPnKrucLty7UFQ0AszzdZB6JJIErwNPfL+VlPruNDFABI0Mxa4z/vmBdh9z
 I8SRGyCD66BPKPXq1CI5+YvI+eWZI8SvTbwM+Qq5/70gn8/hFAdebem3YEMZXC3APtmJUKZY
 X/yjdsbC2gKpAs+Te3tiF2ESzFffWi9UL8h5j0jDoKpFp/MRpqxj7yZwCe7AppWa3hYBlyUC
 3fna52EW+sQaCKVOsJhlyALVbe7S48m2xGjrwz6xKR9LurS5CIYsYjv1N9v5+3cjR0y7yB7D
 9yB02GRSGF5hmcIRz4w3KBirk1x01KD0a9ljPxFEdxc+ehJXxwkNZ7T0eN6Ecr+WgHfcdeTT
 lapXNGmDSs2TtIrzN9dK3p6TvG/jwuL9CqjBrUYjbiCBZp8pqfX0GL2Ke5+xmzA2a1niEMpF
 JhhL2qj04V//g7fA4PT236enauuMJ8bxiPL72CFhT6FvEheXAp9S43KUHYYY0aQpM749ETER
 vmjBalxYVgJ8tKLNqYfMo6htl5BXvq2YLzj
IronPort-Data: A9a23:c2lriKOKU+9zDUnvrR2Cl8FynXyQoLVcMsEvi/4bfWQNrUok3jEBz
 2ZJCD+Gbv7eZTOhLYonbdy0/ExQ7J+Dx9NmQQZtpSBmQlt08vbIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliefTAOK5ULSfUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8tuTS93uDgNyo4GlD5gVkPagR1LPjvyB94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD8fwXG8M49m/c3Kd/
 /0W3XC4YV9B0qQhA43xWTEAe811FfQuFLMqvRFTGCFcpqHLWyKE/hlgMK05FaMT3LsvJ15Sz
 PwnDmE2aQHEhbKskIvuH4GAhux7RCXqFLBG4jc5lmGfUqdgGMyfds0m5/cBgW9235sTW6+AO
 oxAMmQHgBfoOnWjPn8cCJs4kOOlnFHwfjtfrV/TrLA28W/VxUp83KWF3N/9I43UH58JwhvEz
 o7A1z2hAQ0rBfai8jqmySy3lsHUnQjqUatHQdVU8dY03wXInDx75ActfV6wruO+hGa9VshZJ
 khS/TAhxYA29Uq2Xpz4WBGlpHOflgATVsAWEOAg7gyJjK3O7G6k6nMsF2UfLYV46YpvHmFvj
 wLR2d/4AzVqsbbTQGic5LCSpHW/NTV9wXI+iTEsYwAjvoHFn50Kji3pH+1kAem33selIGSlq
 9yVlxTSl4n/nOZSifrnpACe2Gn8znTaZlVvvFiPBQpJ+is8Pdf9NtD1sTA3+N4adN7xc7WXg
 JQTdyFyBsgyEJqWkyrlrA4lTOz2vqft3NExhTdS83gdG9eFoiDLkXh4um0WGauQGp9slcXVS
 EHSoxhNw5RYIWGna6R6C6roVZt2lPW7TY+4C6iOBjarXnSXXFTYlM2JTRLJt10BbGB3+U3CE
 c7HIJv0UR7294w+kmLeqxghPU8DmH9mnjmDLXwK5wmh0KSTfmWUVaZNN1XGZ/o4/qSCqW3oH
 yV3a6O3J+FkeLCjMkHqHXs7aAlSdRDX87in9JcMHgNCSyI/cFwc5wj5mut7JtY7wPoKzo8lP
 BiVAydl9bY2vlWfQS3iV5ypQOi0Df6TcVpT0fQQAGuV
IronPort-HdrOrdr: A9a23:Kok5+KDuS3FkOVvlHegmsceALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPEfP+U0ssHFJo6HiBEDyewKnyXcV2/hYAV7GZmXbUQSTXeZfBOfZogEIXheOjtK1tp
 0QOJSWaueAa2SS5PySiGbXLz9j+qj/zEnCv5a9854Zd3APV0gW1XYdNu/0KC1LbTgDIaB8OI
 uX58JBqTblU28QdN6HCn4MWPWGj8HXlbr9CCR2SiIP2U2rt3eF+bT6Gx+X0lM1SDVU24ov9m
 DDjkjQ+rijifem0RXRvlWjo6i+2eGRheerNvb8y/T9GQ+cyjpAo74RGIFqiQpF7t1HLmxa0u
 Uk7S1QeviboEmhA11d6SGdpzUIlgxeoUMKgGXo/kfLsIj3Qik3BNFGgp8cehzF61A4tNU5y6
 5T2XmF3qAnei8osR6NkuQgbSsa4nacsD4ni6oennZfWYwRZPtYqpEe5lpcFNMFEDjh4I4qHe
 FyBIWEjcwmOG+yfjTcpC1i0dasVnM8ElOPRVUDoNWc13xTkGpix0UVycQDljML9Y47SZND++
 PYW54Y4o1mX4sTd+ZwFe0BScy4BijERg/NKnubJRD9GKQOKxv22uzKCXUOlZKXkbAzvesPcc
 76IS1lXEYJCjPTNfE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,232,1669100400"; 
   d="scan'208";a="196224454"
Received: from 136-165-135-150.dynamic.arizona.edu (HELO [10.138.79.144]) ([150.135.165.136])
  by esa6.hc4604-54.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 09:14:16 -0700
Message-ID: <4401797a-add3-86d8-9283-0ccb3c04f541@genome.arizona.edu>
Date:   Fri, 20 Jan 2023 09:14:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
From:   Chandler Sobel-Sorenson <chandler@genome.arizona.edu>
Subject: Re: [EXT]Re: When adding a module, what does "Exec format error" /
 "Skipping invalid relocation target" mean, and how to fix it?
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org
References: <0f95a92e-d898-562e-06d9-8e0456062e36@genome.arizona.edu>
 <Y8nbdxufr3ysl+wi@bombadil.infradead.org>
Content-Language: en-US
Organization: Arizona Genomics Institute
In-Reply-To: <Y8nbdxufr3ysl+wi@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Luis Chamberlain wrote on 1/19/23 5:08 PM:
> As of v5.10 we now have merged commit 14721add58ef267344bee254bc276c9139b7b665
> ("module: Add more error message for failed kernel module loading")
> which helps expand on this being more friendly:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=14721add58ef267344bee254bc276c9139b7b665

Thanks Luis!  Can we interpret these commit insertions in relation to this error from 4.19?  So "Exec format error" is really meaning "bad WRITE|EXEC flags"?  or are we still stuck in the dark?


> That's from apply_relocate_add(). The locs are supposed to be
> 0 and they are not so it bails. That relocation type is 1 so
> R_X86_64_64.
>
> https://en.wikipedia.org/wiki/Relocation_(computing)

I can't say I understand much of this, does it mean anything to you, in relation to these particular errors?


> Did you really build the module yourself? It doesn't even seem
> you have kernel headers.

Well, I have to say that GNU make built the module, after I issued `make` command, is that what you mean? `linux-headers-amd64` package is installed and /usr/src/linux-headers-4.19.0-5-amd64/ and `make /usr/src/linux-headers-4.19.0-5-common/ are there.  Plus `make` is entering "/usr/src/linux-headers-4.19.0-5-amd64" to compile the modules

It would be nice to know the actual cause, probably stemming from me and something I did, since:  The previous version of the modules were loaded and working great, in fact system uptime is 741 days now.  I unloaded/removed those modules and uninstalled the old software, then configured, built, and installed the latest version of the driver/modules.  These new modules were also inserted fine several days ago, producing no errors.  In order to help out another user with some troubleshooting, I removed the new modules

