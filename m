Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EDE30EF88
	for <linux-modules@vger.kernel.org>; Mon,  2 Feb 2026 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031668; cv=none; b=OdJHXIWA5b4jYBu8KBHeCdA5eVrREjKcavgRwbCKr4Vx22RRpcGkuv+KdhNGIQDbakgr5VW6kIdRFnCB11V8el8FPODw8KiNi96dkNwg5d5HdQFol1v9k+KEAA2Su7JPNH5PDGjriopNX5pQKcxmk7SqiyX9xYIEwR+MGWfLsK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031668; c=relaxed/simple;
	bh=b5+h1ZvPwA1I9hvBi0e/UCJgGnedMcqNKfhP1WPCgtI=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=D7Flm57PGOON60OX2ToLrIQajGkoBWNlwmuH97blAHB8UhAZ2zLEpvFEboADPH2qFx3u2S/+HXh8ZT37XoKZ2rlS7igZKicojkniTcz00vOerSTAC1Y6BNqZjQpMTpPjcqOS7TeeFrHBJujNtN+v6PtrCELQsv/mT4XUDld1ua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ng+ABED6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ng+ABED6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770031666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vt8i1i3wyzdt1qdgU9XEF1v51S15yEQJ5w2cnkXWKgo=;
	b=Ng+ABED6IM18FJsXMXvR0XzDEzES8aIe9EjRULX0wYq8LQ+ggscNTfloEkAwkncQ28PHQ4
	6r6vKeCi2UgwkfkM6VcP85A+ohI2ZqyJu1zgncvhPd4A2KnQmYb1V/hAEnbnc+7HyVEGp5
	nHB10aQ4Q7B9ftQJ/BKER1/wyM8mxmE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-fdMkf_IhMxiHfYncgiWY3Q-1; Mon,
 02 Feb 2026 06:27:45 -0500
X-MC-Unique: fdMkf_IhMxiHfYncgiWY3Q-1
X-Mimecast-MFC-AGG-ID: fdMkf_IhMxiHfYncgiWY3Q_1770031663
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62B9B1956046;
	Mon,  2 Feb 2026 11:27:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.164])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 849701956053;
	Mon,  2 Feb 2026 11:27:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2403737.1770031462@warthog.procyon.org.uk>
References: <2403737.1770031462@warthog.procyon.org.uk> <20251111154923.978181-3-petr.pavlu@suse.com> <20251111154923.978181-1-petr.pavlu@suse.com>
Cc: dhowells@redhat.com, Petr Pavlu <petr.pavlu@suse.com>,
    David Woodhouse <dwmw2@infradead.org>,
    Luis Chamberlain <mcgrof@kernel.org>,
    Daniel Gomez <da.gomez@kernel.org>,
    Sami Tolvanen <samitolvanen@google.com>,
    Aaron Tomlin <atomlin@atomlin.com>, keyrings@vger.kernel.org,
    linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sign-file, pkcs7: Honour the hash parameter to sign-file
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2404480.1770031659.1@warthog.procyon.org.uk>
Date: Mon, 02 Feb 2026 11:27:39 +0000
Message-ID: <2404481.1770031659@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

David Howells <dhowells@redhat.com> wrote:

> @@ -56,6 +56,7 @@
>  	defined(OPENSSL_NO_CMS)
>  #define USE_PKCS7
>  #endif
> +#define USE_PKCS7
>  #ifndef USE_PKCS7
>  #include <openssl/cms.h>
>  #else

Apologies, that line was so I could debug it and should've been removed.

David

