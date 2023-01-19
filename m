Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7933C004D4
	for <linux-modules@archiver.kernel.org>; Thu, 19 Jan 2023 19:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjASTq3 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 19 Jan 2023 14:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjASTqZ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 19 Jan 2023 14:46:25 -0500
Received: from esa.hc4604-54.iphmx.com (esa.hc4604-54.iphmx.com [207.54.93.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9EE8F6D7
        for <linux-modules@vger.kernel.org>; Thu, 19 Jan 2023 11:46:23 -0800 (PST)
X-IPAS-Result: =?us-ascii?q?A2HMAQDenMljAIilh5YNTR4BAQsSDEAJiyGCYqong1QGC?=
 =?us-ascii?q?QEBAQ9EBAEBhAaBAAKFHiY4EwECGQEBAQUBAQEBAQEGAgEBAQECDAE6UoUvg?=
 =?us-ascii?q?n4ihAcCAQMjDwEFNhsLGgIfBwICVxMIAQGCeqQuAYogeoEygQGfQwmBdIEUL?=
 =?us-ascii?q?Ic5dohyQ4INgTwPgj0HMD6FEYMLgmcEmwSBO3yBJw6BSIEaAgkCEzYlBA4DG?=
 =?us-ascii?q?SsdQAIBC20KPwE1CQILSisTBxsHgQgqKBUDBAQDAgYTAyICDSgxFAQpEw0nJ?=
 =?us-ascii?q?mkJAgMhYQUDAwQoLQk/BxURJDwHVjcBBQIPHzcGAwkDAh9PWhYCLhETBQMLF?=
 =?us-ascii?q?SpHBAg2BQYbNhICCA8SDwYmQw5CIRY0EwZ5DQsOEQNQOIEVBC+BZwZRn3UTQ?=
 =?us-ascii?q?4FnpB+eEYE2g3qgVAYPBC6DZhOlMZdLgkyff4VBgXmBfzMaCB0TO4JoUSiOV?=
 =?us-ascii?q?445gRACBwEKAQEDCYtFXgEB?=
IronPort-PHdr: A9a23:1uRDihMPMzL0vXNIxp0l6nbeDRdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDv6gr1QaRFtyBurptsKn/jePJYSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pHNYwhEniexba5uI
 Bm5sAndqM0bipZ+J6gszRfEvnRHd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U
 6VWACwpPG4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Uims4
 qt3VBPljjoMOjgk+2/Vl8NwlrpWrhGvqRNwzYHafYGbOuRwfqPaf9wVWWVPU91NVyFCGI6wc
 5cDAuQDMOtesoLzp0EOrRy7BQS0Gu7vyiVHhnnr0q0+zeshCxzN0hEnH90VrnvUqMz5OroVU
 eCv0qbIyy7Db/RQ2Tzg74XHbhAhruuKXb1tdcre11MvGhjKjlqOr4zlODaV2foXv2eB9epgV
 OOui2khqw5ruDSg2NojipTQi48T11vL+jl3zpwvKt2kVE50f8SkEJ1IuiyZOIV7Xt4vTmBmt
 ig617ELtoK2cDYExpkkxRPRa/KJfoeG7B79WuicIit0iGxkdb+hiBi/80euxOPyW8e7zltHq
 DdOnNrUtn0VyhDe6tSLRuFg8kqv2TuDzR3f5+BELEwuiKbWJZ8sz7gtnZQJq0vDBDX5mEDug
 a+TcUUr5/an5vz8YrXjup+cL4h0ihziMqg2msywH+A4Mg8WUmef5OiwyKfv8VD3TbhJlPE7k
 K3UvIrHKckUqaO2BRdZ0ocl6xmhEzeryMkUkHkbIF5fZR6KgYjkN0vTLP35DfqzmUmgnTlqy
 vzeO73uGJTNLnzNkLf7erZ97lZRxxYzzd9F4ZJbF7UBL+zpWkLqu9zXEBk5Mwuxw+n5Etlyz
 JkeWWOOA6+eNqPdq0WE6fwyLOmRfIMVvi3yJOA/5/HylX85hUMdfa6x0JcKcHy4BOhpI12FY
 XrwhdcMCWMKvgs4TOz3h1yOSDtTZ3GvUKIh4jE0FpmmAJzdRoCinrOBxj23Hp5IaWBcDFCDD
 3Poe5+DW/cWZyLBavNmxzgFU6WxDoom2QyquRTS1bVqNKzX9zceuJal08J6tMPJkhRn3jx9C
 ciZ3nvFdGZ+k2dNfDgs0aZkpko1nlyD2K50h/FCPdNe4fRMX0EzL5/OyOpzTd3+R1SSLZ+yV
 F+6T4D+UnkKRdUrzopWC3s=
IronPort-Data: A9a23:dxTS26JMioWuOk5aFE+R35UlxSXFcZb7ZxGr2PjKsXjdYENSgzFWz
 TEaXj/UbqqJNGKmfNh0OYi//UIO68eDm4MwSVRorCE8RH9jl5H5CIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHfykTbaeYUidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw//F+UwHUMja4mtC5QRnPKET5jcyqlFMZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAMEhhXJ/0F1lqTzTJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUfkFPLzOTWXWV+ACQqflO1q8iCAn3aMqUq4eVbUEZky
 cceLW4PPxeMqt+b/rOSH7wEasQLdKEHPass4ykmlGqJS6l3B8mfH5CiCd1whWpowJkVQLCHO
 ZdfMGExBPjDS0Qn1lM/A5I3muusi2PXfDBer1eY46Mt4nrUygU33bTwWDbQUoXbGJoLzh3A/
 Aoq+Uz9AAodLfLO5QHZ/2itntbpjSjQdoI7QejQGvlC3gLLnTZDYPEMbnO/oP+kmgu7XN5CL
 0EP0jQhoLJ090GxSNT5GRqirxa5UgU0AoEOVrRktUTUkfeRulvBQGQVSDdEaddgvdU3Vzss3
 xmEk86B6SFTXKO9e2me2uazhw+JPy1LLz4FagI5YDUEyoy2yG0stS4jXuqPAYbs0IKuSGuqm
 2/axMQtr+5J15NTjM1X6XiC2mv098SUFmbZ8y2NBgqYAhVFiJlJjmBCwWTG5u1HKu51pXHR4
 SddyqByAA0KZKxhdRBho81UQtlFH97fbFXhbadHRvHNDQiF9X+5Zpx36zpjPkpvOctsUWa3P
 xOK5FgJv8IOZCHCgUpLj2SZUJtCIU/ISY2NaxwoRoEmjmVZLVPWoXkyDaJu9zmzyCDAbp3Ty
 b/FLp73VyZy5VVP0Ty3WeoHyr4312g5yyvaX5HpyBKuuYdyl1bJIYrpxGCmM71phJ5oVS2Qq
 o4HXyd840QAC7aWj+i+2dd7EG3m2lBlVc+m8JcJLLPrz8gPMDhJNsI9CIgJI+RN95m5XM+Rl
 p1hcie0EGbCuEA=
IronPort-HdrOrdr: A9a23:xhV6Aq9yoOMV5Ckjw85uk+DWI+orL9Y04lQ7vn2ZKCYlFfBw8v
 rE9sjzuiWZtN98YhwdcKm7Scu9qBDnhPpICPcqU4tKNTOO0FdASrsC0WLM+V3d8kbFmdK1u5
 0QEJSX47DLfD1Hsfo=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,229,1669100400"; 
   d="scan'208";a="195768302"
Received: from 136-165-135-150.dynamic.arizona.edu (HELO [10.138.79.144]) ([150.135.165.136])
  by esa7.hc4604-54.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 12:46:23 -0700
Message-ID: <40b52683-654b-da7d-05d9-3fc5c7828255@genome.arizona.edu>
Date:   Thu, 19 Jan 2023 12:46:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: When adding a module, what does "Exec format error" / "Skipping
 invalid relocation target" mean, and how to fix it?
Content-Language: en-US
From:   Chandler Sobel-Sorenson <chandler@genome.arizona.edu>
To:     linux-modules@vger.kernel.org
References: <0f95a92e-d898-562e-06d9-8e0456062e36@genome.arizona.edu>
Organization: Arizona Genomics Institute
In-Reply-To: <0f95a92e-d898-562e-06d9-8e0456062e36@genome.arizona.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hello?  Does anyone see this?  or, am I supposed to file a bug report to get through?  This is the relevant mailing list for the errors indicated, yes?


Chandler Sobel-Sorenson wrote on 1/17/23 5:42 PM:
> I'm trying to update some drivers.  After uninstalling the old drivers, removing the modules, and installing the new drivers, the new modules are unable to be added.
>
> For example:
> [...]
