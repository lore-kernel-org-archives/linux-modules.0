Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F150623D0;
	Fri, 28 Jun 2024 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594989; cv=none; b=EiMSrwcyp24lXrpuoBp+AKLPPfti/+njINVfPGojMI4srFwFHAIG82ip7tBCrJW0R9hAJg0ry1dNPtekV9hIM+eUYK2IvwewsjRgYrUKnzWew5ji9WC8tFlyJxvWxhbicEAjt9ixinWXn2mRQxRqw//sMWW4mfyNx8gkEdJ4WxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594989; c=relaxed/simple;
	bh=BVzadzBv3km8XG6p6BKHxmV5dz6nhJeKjWoOEMkG+jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrA+RG5hTbiWRS3v9C1oezfdO+JyaJAIqtjFrST01jOSllsD39srlCECngolk4/wNAmnI2X7Vb94hDVq+P62+vZfX2ws/sh7TNAwsdymC7oJyIu8hpSshQjgXps2YmNFHRqvNTt7uJcn2k9+MTfLql3zwn5tU72S2ysUP2YDgBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jW4Zgyaj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jW4Zgyaj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Sgu1R12gnRao8J6vIMSWPtxCpqtZokT+JjQHwgSLSU8=; b=jW4Zgyaj9EIcAYS4j4F/3j2EF0
	lEzZeWPOXwMjfOjDPzGZym3D/PLMspR2kRZNnVKhQuODUYUGH8VxVcA2eb+YwpwJbHEpkWcf/KstI
	Li/hnWKKjO3CmpCisFwkH6w0KjAVWkdSGAdfwHeVrdot6Fz0NrTyXvhV2DU7BDc6HwOWhCm0xF3EF
	zd9BUdeSLEByZ220TPXMVH2FWWJRhsp8+udslbC4cUlpMTo5xixlxqPmxmFvK/I6aWWUvAv/Y1xHV
	UxhE6b/2SSpa7NiSHiRj4TCkKSOOF4lWv4XYO4zfA6lvM2lI3eB0sSN8UAnYXAuOKmkGMd4posG/z
	BdTORQLg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNFCz-0000000ETQN-2OTt;
	Fri, 28 Jun 2024 17:16:25 +0000
Date: Fri, 28 Jun 2024 10:16:25 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Yusong Gao <a869920004@gmail.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] module: Add log info for verifying module signature
Message-ID: <Zn7v6XGbSTxo3T4f@bombadil.infradead.org>
References: <20240628103923.1677347-1-a869920004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628103923.1677347-1-a869920004@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Jun 28, 2024 at 10:39:23AM +0000, Yusong Gao wrote:
> Add log information in kernel-space when loading module failures.
> Try to load the unsigned module and the module with bad signature
> when set 1 to /sys/module/module/parameters/sig_enforce.
> 
> Unsigned module case:
> (linux) insmod unsigned.ko
> [   18.714661] Loading of unsigned module is rejected
> insmod: can't insert 'unsigned.ko': Key was rejected by service
> (linux)
> 
> Bad signature module case:
> (linux) insmod bad_signature.ko
> insmod: can't insert 'bad_signature.ko': Key was rejected by service
> (linux)
> 
> There have different logging behavior the bad signature case only log
> in user-space, add log info for fatal errors in module_sig_check().
> 
> Signed-off-by: Yusong Gao <a869920004@gmail.com>
> ---
> V3: Clarify the message type and the error code meaning.
> V2: Change print level from notice to debug.
> ---
>  kernel/module/signing.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/kernel/module/signing.c b/kernel/module/signing.c
> index a2ff4242e623..826cdab8e3e4 100644
> --- a/kernel/module/signing.c
> +++ b/kernel/module/signing.c
> @@ -67,6 +67,31 @@ int mod_verify_sig(const void *mod, struct load_info *info)
>  				      NULL, NULL);
>  }
>  
> +static const char *mod_decode_error(int errno)
> +{
> +	char *errstr = "Unrecognized error";

This is not safe. You can just extend the existing debug switch for
strict module loading and re-use the variable there and use that,
for example

diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index a2ff4242e623..9111822116e6 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -106,6 +106,9 @@ int module_sig_check(struct load_info *info, int flags)
 	case -ENOKEY:
 		reason = "module with unavailable key";
 		break;
+	case -EKEYREJECTED:
+		reason = "Key was rejected by service";
+		break;
 
 	default:
 		/*
@@ -113,6 +116,7 @@ int module_sig_check(struct load_info *info, int flags)
 		 * unparseable signatures, and signature check failures --
 		 * even if signatures aren't required.
 		 */
+		pr_debug("Verifying module signature failed: %s\n", reason);
 		return err;
 	}

Also certs/system_keyring.c already has a lot of pr_devel stuff too, so
do we really need this?

  Luis
