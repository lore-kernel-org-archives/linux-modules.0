Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F0131584
	for <linux-modules@vger.kernel.org>; Tue, 10 Oct 2023 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lop/4juc"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21768F;
	Tue, 10 Oct 2023 15:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=90TfTQ0HXtaxpP2N+kX5JJUdpzOu8ILN/U8ZS/CUaG4=; b=lop/4jucpEXHelFQId1crSEMAC
	Gn32k7Bk/APUtM7fo9a1ua/e3qWsB79DoGlaKkj1X6fcyXH+FYcXlag5+sTsEb9OiWTDzl4IaqSr1
	mTD7AILBHYRnAMRuv4Qj9/qKPsSCJzt8cSmPp8I3SBITTp2C3MirJfzvwzUmf6Lk6GR5eQ41WssDi
	V/JCqInkk9bcWRDixVfTwmSuF+ojwsgozE7VuwNg89zcQXzs/isFCVnZs6D4VBuEHqZTnInHlFSPt
	lKK+wixmi7wlv18SQzt8Cocdk7JW7D//xwNTl9dOFYPwVhRsq2hEI6f0uqp6xo/1s6vT6BnTGi6+H
	nC9tuvJQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qqLN9-00EHUI-0o;
	Tue, 10 Oct 2023 22:38:39 +0000
Date: Tue, 10 Oct 2023 15:38:39 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc: David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-modules@vger.kernel.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: Limit MODULE_SIG_KEY_TYPE_ECDSA to SHA384 or
 SHA512
Message-ID: <ZSXSb9oQxWukme4d@bombadil.infradead.org>
References: <20231010212755.64744-1-dimitri.ledkov@canonical.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010212755.64744-1-dimitri.ledkov@canonical.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 10:27:55PM +0100, Dimitri John Ledkov wrote:
> NIST FIPS 186-5 states that it is recommended that the security
> strength associated with the bit length of n and the security strength
> of the hash function be the same, or higher upon agreement. Given NIST
> P384 curve is used, force using either SHA384 or SHA512.
> 
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---

I'd imagine this could go through crypto tree, as folks more in tune
with these requirements would be more aligned with what we need.

  Luis
