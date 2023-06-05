Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299C7C77B73
	for <linux-modules@archiver.kernel.org>; Mon,  5 Jun 2023 15:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjFEP3D (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 5 Jun 2023 11:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjFEP3C (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 5 Jun 2023 11:29:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B27FAD;
        Mon,  5 Jun 2023 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1rcoNzbbjZnYRzwraIv0WdpuJsYjOVuqn77l2kvZLVc=; b=KuIODdFe+5VH/pYaz2po08qNKC
        S/myRn+CjgR4roAT1GngpoQLir7DW0wRBGOaooq1EXBT6Ihp5/nIdWr3VXuo2Gf223ekag1aPD332
        X8vzjPpOmNFFe4ktbZV2mS47wfHPSpT3BttlVorEHxyHM4yj7no8A4Ngz4gw04OAvIRJQ0a3U3V6Z
        nRCRb009oifDS37IkiFTztNX3lErrtwbEn6ApW8aX2BV17XHgrvT/xZoiF9Jq8HiSbfruQPi9Dhu7
        lSiy5E07rvBV+1uNKI8GvDnYhrN/Gsu44tRiac/vkevy7QO/uHh2k2xxAs85K5CALd+isgg5mSoc4
        AvSNtQQg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6C8P-00FxA8-2H;
        Mon, 05 Jun 2023 15:28:41 +0000
Date:   Mon, 5 Jun 2023 08:28:41 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Hildenbrand <david@redhat.com>, song@kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johan Hovold <johan@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
Message-ID: <ZH3/KVCHhX4D4yh9@bombadil.infradead.org>
References: <ZHSeOUpKtyc8VKx5@hovoldconsulting.com>
 <ZHTCK2_1pF61yWIr@hovoldconsulting.com>
 <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
 <ZHYitt7P7W+8ZlSB@bombadil.infradead.org>
 <499e30cc-d015-8353-1364-50d17da58f47@redhat.com>
 <ZHd8bLPY4OQCb/Z5@bombadil.infradead.org>
 <ba60bca6-b682-4c27-3c54-2512b6f16151@redhat.com>
 <ZHoTFDkPIgglW0sU@bombadil.infradead.org>
 <fa3f1a1f-edc6-f13b-cc84-f3264b03b0b1@redhat.com>
 <ZH38lpTHZ/RISC1v@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH38lpTHZ/RISC1v@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jun 05, 2023 at 08:17:42AM -0700, Luis Chamberlain wrote:
> We've gone down from ~6 GiB to ~6 MiB.

And just to also highlight, that was just for for the KASAN enabled case, and
for !KASAN we went from ~18 GiB to 0.

  Luis
