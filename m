Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F9738F87
	for <linux-modules@vger.kernel.org>; Wed, 20 Mar 2024 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925574; cv=none; b=tKnkLd+sv/vwVatqBlPQ0mck+ebEkNTyzRuV73/PJisqJQCP9MsxnsuREzaaBHMOYWcv6xLUVerCy2T0E0OaLcSIoze9Gi4IusPWMp+s/+TR5mdkI3MmuotWNWzdvFLA6299SMBdCBj+LGeayqcpjIjUFau4YjGApbxIvjTmesM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925574; c=relaxed/simple;
	bh=8lwjyQITuheNeB9Vu3OmDxtdVLx5btiGj0xDyxl4XLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jyq0maUOSmq3Tgz2z5FHmQPVhF697UfWLzHZ0ZO4h2PWI6oqvFCzf7QFtWRYla8Poi8bC2vW9iIlnFuhxq02/Q8vjhA9dOWWe7NdVXnOs+Xlf0oK6z66pxk72yFto/VI8GNMqwEXyA4lPZIAuflToYwfC+Nb/YeJ8PEBjpcG4+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NilXVE6i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NilXVE6i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710925571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRBOfxfdF+xeswjN/1XVD3vXzVCiL8X7F95pf6KZOEY=;
	b=NilXVE6i8ZQkf0STR+CS0OYwbevUha6WT3dEP/s3GROU9ApBXipLsaDrXvHGouq9wLLP4g
	7RnLISw0qGiLz52pvOM6qEHvggZov6PRcAnrB21x1xo2Mh63uLUCkqZS71c+yxV7u6cEIw
	0K5KCEj9ysUk7Zohgd3rzBJ1hxHXULE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-NoLFaOk1PjKoZxP1F5TBIg-1; Wed,
 20 Mar 2024 05:06:06 -0400
X-MC-Unique: NoLFaOk1PjKoZxP1F5TBIg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BA5A383E13E;
	Wed, 20 Mar 2024 09:06:06 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.246])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E958B10E47;
	Wed, 20 Mar 2024 09:06:04 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: lucas.demarchi@intel.com
Cc: emil.velikov@collabora.com,
	gustavo.sousa@intel.com,
	jtornosm@redhat.com,
	linux-modules@vger.kernel.org,
	mcgrof@kernel.org,
	md@linux.it
Subject: Re: [PATCH kmod] libkmod: add user soft dependecies
Date: Wed, 20 Mar 2024 10:05:56 +0100
Message-ID: <20240320090559.8076-1-jtornosm@redhat.com>
In-Reply-To: <wleo3wydlkqka5x276w6kl3g4jqii3ddpsjrp2cypmraxuyuc4@g6tn45owkssw>
References: <wleo3wydlkqka5x276w6kl3g4jqii3ddpsjrp2cypmraxuyuc4@g6tn45owkssw>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

> so it's basically a pre softdep, but without libkmod (userspace) trying
> to load it before the module requested. So, it's "softer than soft" or
> even "something before pre".
>
> Thinking this way I find the name chosen odd, as the *user*space side of
> module loading will actually *not* look into those deps.
>
> Cc'ing some more people for suggestions, as I only know I don't like
> "user", but my suggestions may considered equally bad too:
>
>        dull / still / early / runtime_request / maybe
Ok, I thought of "user" because it was only going to be used by user
applications but it could have other interpretations.
Maybe another idea: "internal" to inform that there are dependencies and
these are going to be solved internally?

> Anyway, we will need to explain exactly what this is about in
> modprobe.d(5).
Ok, I will complete it when the dependency name is decided.

> Other than the use case of creating a initramfs and not
> missing any module, I don't think there would be any, right?
Yes, my purpose is only that, I don't have detected any other case.

Thanks

Best regards
José Ignacio

