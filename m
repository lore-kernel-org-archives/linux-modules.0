Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C8D944E
	for <linux-modules@vger.kernel.org>; Fri, 20 Oct 2023 05:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E20D64;
	Thu, 19 Oct 2023 22:54:48 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qtiT2-0097br-3n; Fri, 20 Oct 2023 13:54:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Oct 2023 13:54:45 +0800
Date: Fri, 20 Oct 2023 13:54:45 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-crypto@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Do not offer sha224 for built-in module signing
Message-ID: <ZTIWJYNNu5mQlqky@gondor.apana.org.au>
References: <20231010212633.64042-1-dimitri.ledkov@canonical.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010212633.64042-1-dimitri.ledkov@canonical.com>

On Tue, Oct 10, 2023 at 10:26:33PM +0100, Dimitri John Ledkov wrote:
> sha224 does not provide enough security against collision attacks
> relative to the default keys used for signing (RSA 4k & P-384). Also
> sha224 never became popular, as sha256 got widely adopter ahead of
> sha224 being introduced.
> 
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---
>  kernel/module/Kconfig | 5 -----
>  1 file changed, 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
