Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88651332EA3
	for <linux-modules@vger.kernel.org>; Mon, 26 Jan 2026 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769426753; cv=none; b=jH/j/BbUamMR/7CeJrqtHgyYn/Ccn0YRFg9oHkWAHx8rUVRYg15Vyms60hnp5YJO9SCaKpg1dhNuSYjqPivS73U+I4vb27dIGTcIAHst6zVQO9ItPDQ5fJe60Vzpw0vqN3Tvny5TN8MFUAHjONXgnxSN8OVYbS+jtyBYuhWOeyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769426753; c=relaxed/simple;
	bh=qbabzOBct0raWmkfNNwqKkzge9KEKM7B+e5ggwjjto8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=hr1aP/hsINmM7iLParckkZZ9hHZDj4Us7KPZ4wBOJVaqjjgt3Auv2H7fYX2nFXe3Ibrb3eDFASEXe7TkCFNQ0hcgkQjQbUuxPssmlDq+cvrKfsCmuMxqwDUdtnYtwF39qhaAPFvCQdFLPojzbV8Q9Sv/vjFMbqR2KqOw6eoZ6xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fFNrnFUT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFNrnFUT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769426751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TNLEmaMi6ah7uFVlqTiBOf87rjmNddmz1tzblx3XG20=;
	b=fFNrnFUTj1UXDOZBrJ/0GCwj9wwMggVZH1qe+7LuNjGqJ+wZnaluxTZRBIJZNqxLo7OoUz
	BUYXNDKeecrMcwRebpWn9a1JRQG2mRrZN9MC+8UI7ZgJy/8MPQIzE2Y2rouAFn3z3Bjs6i
	3UjX6MlfkYkylSe762DoN98hbI10kX0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-gilud1t_NHeKUDoSkiCCBQ-1; Mon,
 26 Jan 2026 06:25:48 -0500
X-MC-Unique: gilud1t_NHeKUDoSkiCCBQ-1
X-Mimecast-MFC-AGG-ID: gilud1t_NHeKUDoSkiCCBQ_1769426746
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 837201944EB7;
	Mon, 26 Jan 2026 11:25:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.186])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DFD6E1800665;
	Mon, 26 Jan 2026 11:25:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aXYrvMpaQ2rHmFrw@kernel.org>
References: <aXYrvMpaQ2rHmFrw@kernel.org> <20260121223609.1650735-1-dhowells@redhat.com> <20260121223609.1650735-5-dhowells@redhat.com>
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
Subject: Re: [PATCH v14 4/5] pkcs7, x509: Add ML-DSA support
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1903447.1769426738.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Jan 2026 11:25:38 +0000
Message-ID: <1903448.1769426738@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> Why don't we have a constant for "none"?
> =

> $ git grep "\"none\"" security/
> security/apparmor/audit.c:      "none",
> security/apparmor/lib.c:        { "none", DEBUG_NONE },
> security/security.c:    [LOCKDOWN_NONE] =3D "none",
> =

> $ git grep "\"none\"" crypto
> crypto/asymmetric_keys/public_key.c:                                    =
hash_algo =3D "none";
> crypto/asymmetric_keys/public_key.c:                            hash_alg=
o =3D "none";
> crypto/testmgr.h: * PKCS#1 RSA test vectors for hash algorithm "none"
> =

> IMHO, this a bad practice.

You'd think that the compiler and linker ought to be able to deal with
read-only string sharing within compilation units.  I don't particularly w=
ant
to deal with combining every "none" string within the kernel into one with=
in
this patchset.

I could move back to using an enum of algorithms, I suppose - though again=
,
I'd rather not do that in this patchset.

David

