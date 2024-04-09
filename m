Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9EF13667F
	for <linux-modules@vger.kernel.org>; Tue,  9 Apr 2024 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677848; cv=none; b=KLocbi0Zq+BQxu00y+kqWvUjzlY6tn4NFaTbqLv6owsgtXlkSO3TjNOFthCan5IEwJEwx6kphfEcWmXufFE6PoikKN0rXHS7eVXsP20AMwmXt3VYYNNN4oIEnk9Ned3fWe+EVLMHGwCCchuB/xSAESZgkOVhLjubUefECntylNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677848; c=relaxed/simple;
	bh=pygK1J5JV3O7/AW5QM1tOvRqfQbLIGluOhqx4bED/Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jO7nkM+4Y/cGN25kjymds1L0KMEKYjUObwjfOYj+LxkWDX2O/+eJsnuFYjxlBvC62oIZkBhL95gV9EmugcGlMTbfnLwTAkBSIA9pWsbKinP+OmiFEhVXxjmbWW+qEl0JiozWuGqizgXdGC9AuzKE/Yi3wcZItApSnTgBZdY6SIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FIHutssz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIHutssz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712677846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJ7o/g5OvU2I76hdL75eoRuL3bpxGrQAZ0TmKPfvh+4=;
	b=FIHutssz/DxP43bvS8wvdsBatzASyk+0Q7DDzRpcTi1bndWAC2VJrZ4ipXixUNdPMaU3qy
	m9MckgnWsTES5bdBde9gDJoqw7MPZJ+yOMo2ALUZU/N7Fr6SeLkd4tMpVOKqPsOC7HGvM8
	6vHXJviPDb48sbi87GzaIyIi6UgWfBg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-PTtMy_yzPlaYzZidik78PQ-1; Tue, 09 Apr 2024 11:50:42 -0400
X-MC-Unique: PTtMy_yzPlaYzZidik78PQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 299C980171E;
	Tue,  9 Apr 2024 15:50:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 559D9492BC7;
	Tue,  9 Apr 2024 15:50:40 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: lucas.demarchi@intel.com
Cc: emil.l.velikov@gmail.com,
	gustavo.sousa@intel.com,
	jtornosm@redhat.com,
	linux-modules@vger.kernel.org,
	mcgrof@kernel.org,
	md@linux.it
Subject: Re: [PATCH v2 patch] libkmod: add weak dependecies
Date: Tue,  9 Apr 2024 17:50:29 +0200
Message-ID: <20240409155035.524993-1-jtornosm@redhat.com>
In-Reply-To: <ut6662ojqsf7bksfmqcsvdnmb72xitenjcuwx43qpyi7vv3ymq@drqkyj5cmck3>
References: <ut6662ojqsf7bksfmqcsvdnmb72xitenjcuwx43qpyi7vv3ymq@drqkyj5cmck3>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Hello Lucas,

> Sorry for the delay. I will review this later this week.
No problem!

> For now, I'm a bit confused. Why do we have 2 patches?
>
>	[PATCH v2 kmod] libkmod: add weak dependecies
>	[PATCH v2 patch] libkmod: add weak dependecies
>
> Was one of them sent by mistake?
Yes, one is a mistake but only in the suffix in [PATH v2 ...] that should
be kmod. Indeed the content of the patches is the same for both.
You can choose [PATCH v2 kmod] because as I said the suffix is ok.
Sorry for the confusion, I should have commented ...

> No need to resend now, but it'd be preferred to skip --in-reply-to=<v1>
> and just rely on -v2 and let b4 do its thing to detect new versions.
Sorry again, I didn't know it, next time I will do as you say.

Thanks

Best regards
José Ignacio

