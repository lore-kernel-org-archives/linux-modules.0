Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF93AC433ED
	for <linux-modules@archiver.kernel.org>; Sat, 17 Apr 2021 20:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB66D610CD
	for <linux-modules@archiver.kernel.org>; Sat, 17 Apr 2021 20:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbhDQU7M (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 17 Apr 2021 16:59:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:50988 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236143AbhDQU7M (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Sat, 17 Apr 2021 16:59:12 -0400
IronPort-SDR: vDEtGPgUzhsNo5WQpHR72e0C+ijyuiys2aHTdpS+mgFYJH/u59hAxvrUyhl9vryP/GB3IF09y2
 gR+0N6RALhxg==
X-IronPort-AV: E=McAfee;i="6200,9189,9957"; a="280508154"
X-IronPort-AV: E=Sophos;i="5.82,230,1613462400"; 
   d="scan'208";a="280508154"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2021 13:58:45 -0700
IronPort-SDR: N7fvCaugRSGEEVFexFUm9UIyFzZyVDRv5Pm+KwiN+KJYX6FQLrgxd5q1cZh6VN//I2EOrGITuW
 FhEr7/yhw7QQ==
X-IronPort-AV: E=Sophos;i="5.82,230,1613462400"; 
   d="scan'208";a="616242987"
Received: from chungyus-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.230.204])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2021 13:58:44 -0700
Date:   Sat, 17 Apr 2021 13:58:44 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Seung-Woo Kim <sw0312.kim@samsung.com>
Cc:     linux-modules@vger.kernel.org, lucas.de.marchi@gmail.com,
        gladkov.alexey@gmail.com, sungguk.na@samsung.com
Subject: Re: [PATCH 0/2] harden libkmod-builtin with wrong
 modules.builtin.modinfo
Message-ID: <20210417205844.z4ano23b7wg5drvh@ldmartin-desk2>
References: <CGME20210413112018epcas1p15c2cb9693086133c145845030df145ef@epcas1p1.samsung.com>
 <20210413112315.18907-1-sw0312.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210413112315.18907-1-sw0312.kim@samsung.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Apr 13, 2021 at 08:23:13PM +0900, Seung-Woo Kim wrote:
>The wrong data in modules.builtin.modinfo can cause overflow or
>double free from modinfo with libkmod-builtin. Fix the error
>cases with strict checking.
>
>Seung-Woo Kim (2):
>  libkmod: fix an overflow with wrong modules.builtin.modinfo
>  libkmod: fix possible double free with wrong modules.builtin.modinfo


both commits applied,

thanks
Lucas De Marchi

>
> libkmod/libkmod-builtin.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>-- 
>2.19.2
>
