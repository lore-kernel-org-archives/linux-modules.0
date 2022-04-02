Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38B1C433EF
	for <linux-modules@archiver.kernel.org>; Sat,  2 Apr 2022 04:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239267AbiDBEny (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 2 Apr 2022 00:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbiDBEnx (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sat, 2 Apr 2022 00:43:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD311EFE39
        for <linux-modules@vger.kernel.org>; Fri,  1 Apr 2022 21:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648874522; x=1680410522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mLtKOBmfYTyBq8UeNFZEOum/Th/5mK8pIGuIJ537vWU=;
  b=Lrj0ZYkH7m56PVAwDvlYD1/+8aJV/AlvQD12DHsHTaJKXM4WIu0dbf5Y
   LMLT6HBf94qOGQFLNLPJtDhfZdKmcP642Muh9hpU/f2IKQtWm3LxoHfj1
   3RqYNvuzEft0Af/zMoRg//jp4+Sux/FkMpNt9tHqQs216lMQ8kEGdBQmM
   H5waU0VJQ0sQTU08Bv/LVGLgby9Koqk/j/BiSgD+knT7/kR2SooKrb7jv
   FtBiXXMSsTuo26Nr2xIF0lBkUoqK//1MitiUmS4zBkRgz/qQuxCuM6kS/
   KdSknG8LQHAR27rWHF0Q473pQQtvKbJbh66iihXHN92TIGtT1dEBAJqav
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="259104644"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="259104644"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 21:42:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="548054985"
Received: from kdurai-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.134.219])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 21:42:01 -0700
Date:   Fri, 1 Apr 2022 21:42:01 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Saul Wold <saul.wold@windriver.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH v2] depmod: Add support for excluding a directory
Message-ID: <20220402044201.uexkieiyg2zoih4f@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20220331215628.70679-1-saul.wold@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220331215628.70679-1-saul.wold@windriver.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, Mar 31, 2022 at 02:56:28PM -0700, Saul Wold wrote:
>This adds support to depmod to enable a new exclude directive in
>the depmod.d/*.conf configuration file. Currently depmod
>already excludes directories named source or build. This change
>will allow additional directories like .debug to be excluded also
>via a new exclude directive.
>
>depmod.d/exclude.conf example:
>exclude	.debug
>
>Upstream-Status: Submitted
>
>Signed-off-by: Saul Wold <saul.wold@windriver.com>

tools/depmod.c: In function ‘depmod_modules_search_dir’:
tools/depmod.c:1302:46: warning: passing argument 1 of ‘should_exclude_dir’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  1302 |                 if (should_exclude_dir(depmod->cfg, name))
       |                                        ~~~~~~^~~~~
tools/depmod.c:1273:43: note: expected ‘struct cfg *’ but argument is of type ‘const struct cfg *’
  1273 | static int should_exclude_dir(struct cfg *cfg, char *name)
       |                               ~~~~~~~~~~~~^~~
tools/depmod.c:1302:53: warning: passing argument 2 of ‘should_exclude_dir’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  1302 |                 if (should_exclude_dir(depmod->cfg, name))
       |                                                     ^~~~
tools/depmod.c:1273:54: note: expected ‘char *’ but argument is of type ‘const char *’
  1273 | static int should_exclude_dir(struct cfg *cfg, char *name)
       |                                                ~~~~~~^~~~


I fixed the warnings and changed should_exclude_dir() to return bool.

Applied, thanks.

Lucas De Marchi
