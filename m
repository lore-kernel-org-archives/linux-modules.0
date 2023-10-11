Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858D84689
	for <linux-modules@vger.kernel.org>; Wed, 11 Oct 2023 02:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MyVIx+kl"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5144B94;
	Tue, 10 Oct 2023 19:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ECF3/1WilG3oPuCuQT95CHRb45iMre03wS/vbNRxGFU=; b=MyVIx+klhdf+TiAhgT+Rt8tolB
	vCapYA9ODnH0R/7PAEM1nJC1uN27r3bDSc3yDt+P2Aw9NTrQUXiM6qyZwQm7/pjADj8FC7LciRwEC
	664mxoRJzI8Xj8m3PBh0aY7+ZC6s7U77HEDTju9qCnVtLdA0Q7+QMTRbng8UQkKKab1sfNOuLGW3z
	ebN0CWekKymRFWshTAlTEkXoLHMvgPzHwkd7cgembcawXDiS5spd9i8eRm6+IN1royT+QFABenq1r
	+Wg2EETZ4kE4kG3wtiVxKFD18/O+zWVOJ2bW4cRaCf4xQVQ+WQOn5nZxBimqJpdXzq2fVdsRoS2rN
	l5ReAb3A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qqOqX-00EZyf-0C;
	Wed, 11 Oct 2023 02:21:13 +0000
Date: Tue, 10 Oct 2023 19:21:13 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Joey Jiao (QUIC)" <quic_jiangenj@quicinc.com>
Cc: "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] module: Add CONFIG_MODULE_LOAD_IN_SEQUENCE option
Message-ID: <ZSYGmQhlGKmYXENG@bombadil.infradead.org>
References: <20231009045636.4143-1-quic_jiangenj@quicinc.com>
 <ZSXR7PJmXZpZxQ2R@bombadil.infradead.org>
 <49a0f7c36d8d41abb1204b0780667fe0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49a0f7c36d8d41abb1204b0780667fe0@quicinc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Please find a good email client to reply to patches.

On Wed, Oct 11, 2023 at 01:57:58AM +0000, Joey Jiao (QUIC) wrote:
> Hi Luis,
> 
> > How is ignoring an error ensuring ordering?
> The change is just to disable the schedule_work.

That's different and can be made clearer. Try:

if (!IS_ENABLED(CONFIG_FOO))
	schedule_stuff

> > Why are you making this only now be called with this new kconfig option?
> This sequence loading is especially helpful for syzkaller coverage decoding.
> When kaslr is disabled, address inside core kernel is fixed, so syzkaller can always get right function/line number from addr2line.
> But module address keeps change across rebooting, in first booting, it might be loaded at X1, and at X2 after reboot, and at X3 after another reboot.
> In this way, syzkaller just can't decode correctly for module address. And syzkaller currently uses PC and branch info for coverage guided things.
> 
> There was a discussion previously here https://groups.google.com/g/syzkaller/c/1Pnm_BjrZO8/m/WOyAKx8ZAgAJ for modprobe.

You are missing my point, you are disabling in effect a piece of code
where it was not before.

  Luis
