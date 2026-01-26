Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D43314B6
	for <linux-modules@vger.kernel.org>; Mon, 26 Jan 2026 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769425884; cv=none; b=WYFah1Z3L1i7J44pVM4IaLeT/fO3Dicf6iWuqj7Tuoh4QtkFMNs1FgpZpPbygNVIc9moBdU6fASfqBkQeSWzs1Nz57mMAzoXgf6q/0jCcB5WYVQ/WDmI5d89u5PkwPi0CL1n7o/uz8CwD6R/wsd+IK2v1qdkwa3b5Orc8l3n6y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769425884; c=relaxed/simple;
	bh=GthLvZCwQKIB48Fpys6JOvaMVCJ1h0clP4FMY5Ci0L4=;
	h=In-Reply-To:References:To:Cc:Subject:MIME-Version:Content-Type:
	 From:Date:Message-ID; b=rwqUWmZTi+s5l+yjBWjqwEebawOhJke6b/Jxug5Zr2tRSZtBMZlqOvcRiZyGjAHq2wImHEIhsKy+C/7JjrJGNdhEkDN/G1NUo+alKg6LGVtRSlC6DwNS9rJkUnsepYEDkD0H0ckNS1Du7XTl7MkhDj4bkaKFXa9UzeKtHumPDsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xlu+dY7t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xlu+dY7t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769425882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RpKldkONcFT8Otswws0O8woIeUuD3t8FuXCWB4B+nN0=;
	b=Xlu+dY7t9dMD6XGLM3oGaxRYKp/b3T6N7qFnl8MMkTN/EIY7znkAHsmIihyz1c2kOnX914
	NTqt6tk2n96kDZi/9HrAYN60/sHU58qSqj89ioclpAU8hDQPqGQF9YqYaQJFjCdJ3l9mdd
	NMoZ+aevz2T/lVDDNlj9BCHaIT9+P/k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-1iQiJDkaMNKqli0b2rUgIg-1; Mon,
 26 Jan 2026 06:11:17 -0500
X-MC-Unique: 1iQiJDkaMNKqli0b2rUgIg-1
X-Mimecast-MFC-AGG-ID: 1iQiJDkaMNKqli0b2rUgIg_1769425875
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 437BD1956094;
	Mon, 26 Jan 2026 11:11:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.186])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0B121956095;
	Mon, 26 Jan 2026 11:11:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <aXYq_9XoOx5WaoU9@kernel.org>
References: <aXYq_9XoOx5WaoU9@kernel.org> <20260121223609.1650735-1-dhowells@redhat.com> <20260121223609.1650735-4-dhowells@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, Lukas Wunner <lukas@wunner.de>,
    Ignat Korchagin <ignat@cloudflare.com>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Eric Biggers <ebiggers@kernel.org>,
    Luis Chamberlain <mcgrof@kernel.org>,
    Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
    Sami Tolvanen <samitolvanen@google.com>,
    "Jason A . Donenfeld" <Jason@zx2c4.com>,
    Ard Biesheuvel <ardb@kernel.org>,
    Stephan Mueller <smueller@chronox.de>, linux-crypto@vger.kernel.org,
    keyrings@vger.kernel.org, linux-modules@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 3/5] pkcs7: Allow the signing algo to do whatever digestion it wants itself
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1902787.1769425830.1@warthog.procyon.org.uk>
From: David Howells <dhowells@redhat.com>
Date: Mon, 26 Jan 2026 11:11:08 +0000
Message-ID: <1902869.1769425868@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> >  (1) Rename ->digest and ->digest_len to ->m and ->m_size to represent the
> >      input to the signature verification algorithm, reflecting that
> >      ->digest may no longer actually *be* a digest.
> ...
> These renames emit enough noise to be split into a separate patch.

Yeah, I had considered that, so I've now done that.

> > +		if (sig->algo_takes_data) {
> > +			sig->m_size = sinfo->authattrs_len;
> > +			memcpy(sig->m, sinfo->authattrs, sinfo->authattrs_len);
> > +			sig->m[0] = ASN1_CONS_BIT | ASN1_SET;
> > +			ret = 0;
> > +		} else {
> > +			u8 tag = ASN1_CONS_BIT | ASN1_SET;
> > +
> > +			ret = crypto_shash_init(desc);
> > +			if (ret < 0)
> > +				goto error;
> > +			ret = crypto_shash_update(desc, &tag, 1);
> > +			if (ret < 0)
> > +				goto error;
> > +			ret = crypto_shash_finup(desc, sinfo->authattrs + 1,
> > +						 sinfo->authattrs_len - 1,
> > +						 sig->m);
> > +			if (ret < 0)
> > +				goto error;
> > +		}

Thinking further on this, I think it's better just to do the copy and modify
unconditionally and then in the second case here just call
crypto_hash_digest().  That means we end up doing a single crypto call on an
aligned buffer.  It's not like expect the authattrs to be particularly big for
an RSA signature.

David

