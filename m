Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D46D20E0
	for <linux-modules@vger.kernel.org>; Wed, 20 Sep 2023 21:25:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D0E9E;
	Wed, 20 Sep 2023 14:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MZX+Ciar+KiTX86/Y8wrdDvM8UvduQIZHKQ9a5RcgkI=; b=escJjETw0xCHVfESs/zQjQQIiU
	1e/OpA9K3CYqB3ARetYS/WqM28v1NwUpksqabEHN9YNV/wb1K4CiqE5W/Tp8o4HyVHNLO+v6H5E17
	HTwdbbP+dSCRhWvVm/os3WjBstr+OtQMdv90xPLnd4HOrotJsvBVQn+IV7esUAl88kPCRjuvP3Naw
	Zdagat1+1aGe1K9UWgVosU4CFKHrelbOpBpIxAyjvl+A9krpzaLxLZHVPYhLzPapmb9VosHob128j
	inRgXUUhS1fTXXFwGe7tXsnP73K7qwHpBW7foWxnwEPj33iQfYb4d7MiYrKfc2pQK6fJLVxyukyPe
	iMicNoEw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qj4hN-004GAw-0S;
	Wed, 20 Sep 2023 21:25:29 +0000
Date: Wed, 20 Sep 2023 14:25:29 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module/decompress: use vmalloc() for gzip decompression
 workspace
Message-ID: <ZQtjSdDUJ88CfOYc@bombadil.infradead.org>
References: <20230830155820.138178-1-andrea.righi@canonical.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830155820.138178-1-andrea.righi@canonical.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 05:58:20PM +0200, Andrea Righi wrote:
> Use a similar approach as commit a419beac4a07 ("module/decompress: use
> vmalloc() for zstd decompression workspace") and replace kmalloc() with
> vmalloc() also for the gzip module decompression workspace.
> 
> In this case the workspace is represented by struct inflate_workspace
> that can be fairly large for kmalloc() and it can potentially lead to
> allocation errors on certain systems:
> 
> $ pahole inflate_workspace
> struct inflate_workspace {
> 	struct inflate_state       inflate_state;        /*     0  9544 */
> 	/* --- cacheline 149 boundary (9536 bytes) was 8 bytes ago --- */
> 	unsigned char              working_window[32768]; /*  9544 32768 */
> 
> 	/* size: 42312, cachelines: 662, members: 2 */
> 	/* last cacheline: 8 bytes */
> };
> 
> Considering that there is no need to use continuous physical memory,
> simply switch to vmalloc() to provide a more reliable in-kernel module
> decompression.
> 
> Fixes: b1ae6dc41eaa ("module: add in-kernel support for decompressing")
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>

Applied, and pushed, thanks!

  Luis
