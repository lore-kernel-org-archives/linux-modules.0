Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175D5C433E0
	for <linux-modules@archiver.kernel.org>; Fri, 12 Feb 2021 09:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBAC964E38
	for <linux-modules@archiver.kernel.org>; Fri, 12 Feb 2021 09:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhBLJnH (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 12 Feb 2021 04:43:07 -0500
Received: from mga17.intel.com ([192.55.52.151]:62378 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230060AbhBLJnF (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 12 Feb 2021 04:43:05 -0500
IronPort-SDR: lPYGJ+9ptbt6E8sw+5wf+ZEfGovfRBxAFKUQA2b6+V/mAqQq4jC4Ywo5dAmhpJAATbtaTbgj9T
 VQZqg8qm4GIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="162144659"
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="162144659"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 01:42:23 -0800
IronPort-SDR: sca8ZBf4HtrOey+sAPZmxG11oslF9b+BS74PSL7BUSeR42FSa0n/tuV4Xzz58SMZpJVoK3TjyT
 ib3xdCOTHz/Q==
X-IronPort-AV: E=Sophos;i="5.81,173,1610438400"; 
   d="scan'208";a="437525340"
Received: from aaramire-mobl2.amr.corp.intel.com (HELO ldmartin-desk1) ([10.212.210.126])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 01:42:23 -0800
Date:   Fri, 12 Feb 2021 01:42:23 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-modules@vger.kernel.org
Subject: Re: libkmod mishandles parameters re-quoted by grub2
Message-ID: <20210212094223.yxxnnswhqhczk5an@ldmartin-desk1>
X-Patchwork-Hint: comment
References: <70f1ef6c-d016-de57-82a8-db9d9cc414ef@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <70f1ef6c-d016-de57-82a8-db9d9cc414ef@kernel.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jan 25, 2021 at 09:49:13AM +0100, Jiri Slaby wrote:
>Hi,
>
>when one passes to the kernel a module parameter from grub2 such as:
>  parport.dyndbg="file drivers/parport/ieee1284_ops.c +mpf"
>the kernel receives:
>  "parport.dyndbg=file drivers/parport/ieee1284_ops.c +mpf"
>as grub2 handles quotes this way. It may be a bug in grub2, it was 
>even tried to be fixed, but there is no all-cases-working fix yet:
>  https://bugzilla.suse.com/show_bug.cgi?id=1181111#c10
>
>The kernel parses the parameter correctly, though:
>  parse_one: doing dyndbg params: parport.dyndbg='file 
>drivers/parport/ieee1284_ops.c +mpf'
>
>But libkmod doesn't. When parport is modprobe-d, this parameter is not 
>passed to it.
>
>kmod_config_parse_kcmdline ignores the parameter as:
>  if (is_quoted) {
>    /* don't consider a module until closing quotes */
>
>I am not sure how to fix this, can someone look into it and make the 
>parser similar to kernel's?

We have to ignore ill-formed kernel cmdline and that makes it harder.

I threw out the current implementation and rewrote it into a state
machine. It passes the tests, but it's unfortunate we have to do this,
particularly because we have to re-quote it the "right way" to pass back
to kernel, unmangling it.

I will share the patch shortly.

Lucas De Marchi
>
>thanks,
>-- 
>js
>suse labs
