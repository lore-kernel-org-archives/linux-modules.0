Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E24AC64EC4
	for <linux-modules@archiver.kernel.org>; Thu,  9 Mar 2023 20:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCIU7E (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 9 Mar 2023 15:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjCIU7D (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 9 Mar 2023 15:59:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4033FF2F9E;
        Thu,  9 Mar 2023 12:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=owJaMoMtxEN64DUlKy7PO9Hs/EgMQqVwePryYhex8+M=; b=AlG12XrZF7/pfY0fL8Cj/K1xqm
        Pcab2Qyy/DB+KXZB4DBls0BRUIYBNb3ShVEe+wnnIe+tepbPjwAn6vIpQximhi4f0uxRfQ1KrhwBx
        OkK4h4NI4fUA5ynSJ1M6MRXbEPkgLQ5+8MuT9qbQAJuNBTCxMDXsehP4N+ulEr6bm3aEsDWh/C0FM
        LUg7RssiWE+DBI6Y2rMmzGQYOPKL0FOyZVF5nMqMhEIllzuc/d0twBGYAHmZEKgBZo7uSIp47AVQ3
        oMv0iHbkeKYct8PtUOBY487j/esWARGFvm8R3L3qpxxrt+FchEkfQ0Apvtdepo0P1S8B1O+bBHAuh
        MN0xgj3Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paNLn-00BuAy-Gy; Thu, 09 Mar 2023 20:58:59 +0000
Date:   Thu, 9 Mar 2023 12:58:59 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Cc:     Jason Baron <jbaron@akamai.com>, jim.cromie@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/2] dyndbg: use the module notifier callbacks
Message-ID: <ZApIk1aY/OnDfpOM@bombadil.infradead.org>
References: <cover.1677861177.git.jbaron@akamai.com>
 <5884c688d10c9703fb0457f8839d6becc8657f8f.1677861177.git.jbaron@akamai.com>
 <CQZHTJDTRJXM.3OF3W3WAZBLAK@vincent-arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CQZHTJDTRJXM.3OF3W3WAZBLAK@vincent-arch>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Mar 06, 2023 at 06:57:17PM +0100, Vincenzo Palazzo wrote:
> > Bring dynamic debug in line with other subsystems by using the module
> > notifier callbacks. This results in a net decrease in core module
> > code.
> >
> > Additionally, Jim Cromie has a new dynamic debug classmap feature,
> > which requires that jump labels be initialized prior to dynamic debug.
> > Specifically, the new feature toggles a jump label from the existing
> > dynamic_debug_setup() function. However, this does not currently work
> > properly, because jump labels are initialized via the
> > 'module_notify_list' notifier chain, which is invoked after the
> > current call to dynamic_debug_setup(). Thus, this patch ensures that
> > jump labels are initialized prior to dynamic debug by setting the
> > dynamic debug notifier priority to 0, while jump labels have the
> > higher priority of 1.
> >
> > Tested by Jim using his new test case, and I've verfied the correct
> > printing via: # modprobe test_dynamic_debug dyndbg.
> >
> > Link: https://lore.kernel.org/lkml/20230113193016.749791-21-jim.cromie@gmail.com/
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/oe-kbuild-all/202302190427.9iIK2NfJ-lkp@intel.com/
> > Tested-by: Jim Cromie <jim.cromie@gmail.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > CC: Jim Cromie <jim.cromie@gmail.com>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Jason Baron <jbaron@akamai.com>
> 
> Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

Tag applied too thanks.

  Luis
