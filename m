Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FE315E800
	for <linux-modules@vger.kernel.org>; Fri, 10 May 2024 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715331299; cv=none; b=uLXjoPE6ZRYQDUlXbZ9zeHZW9znnoKBZjle5xU5/iZHHlDwj2389dh3apaUZwBB8BLNyxLiebv90MBcX/8l8JpkxC307CqOcWA4zwSB6fyQ/QHD8mVrJj7iSMNSxtJaRli7NEMbnZjI+x9n4gbGaKTzE91TemdWyWmcYzu7KD9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715331299; c=relaxed/simple;
	bh=Oext9QCRm3qp1ljmGuVJ+5/G39APiXZEk6YUiMRR/1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eC6edaJ3eWU5TJV+uDIEqpj3WQrUdsP5bze8t9EtMIlVSetMxvfmDiSeuW+TcT+IO2Zxyw2vhbwH7l3UzcwACJKiCdPaL0m5d7JMlQ210jmBvCibhEmpphftliXfxPCpxpYEW1ibNxqLYkECbx7cO9s5597XqxJc3RcpS+r+4J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QEQdLuSl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEQdLuSl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715331297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oext9QCRm3qp1ljmGuVJ+5/G39APiXZEk6YUiMRR/1A=;
	b=QEQdLuSlc2aB4HoC8wd7sKcr6te0c9Z3khAWFNN2NDVUPpdmfZVmYJIQhqX9MEebvKGWiV
	zEd8PjiXR9HLP5TmXU8U0SE/aXCQh0iDjyH2peYux7AhR1IW/qkX0JC5eL1rdOjfsI2OFv
	lBvAT7fsfbCiXVNoSbvs6tE9F5ldSKo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-DGK1vVlWMcGqtZbO3QCJWQ-1; Fri, 10 May 2024 04:54:53 -0400
X-MC-Unique: DGK1vVlWMcGqtZbO3QCJWQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FC2C812296;
	Fri, 10 May 2024 08:54:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.109])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 68F6051903D;
	Fri, 10 May 2024 08:54:51 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: lucas.demarchi@intel.com
Cc: jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	mcgrof@kernel.org
Subject: Re: [PATCH v2] module: create weak dependecies
Date: Fri, 10 May 2024 10:54:49 +0200
Message-ID: <20240510085450.293792-1-jtornosm@redhat.com>
In-Reply-To: <5o5jlonbr2ggei7zxh7m2mql3rt6xnmmmo2hv6ktpvi26c7uuw@odtumzc76xoq>
References: <5o5jlonbr2ggei7zxh7m2mql3rt6xnmmmo2hv6ktpvi26c7uuw@odtumzc76xoq>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

> I think it's important a note about backward compatibility. If a system
> doesn't have a new-enough depmod, it will basically not create the new
> weadep file and initrd generators won't be able to use that. Only
> downside is not being able to use the new feature, but it should still
> work as previously.
Ok, good, idea, I will send a new version of the patch with the note.

Documentation/process/coding-style.rst section 8 says to balance the /*
and */, but up to Luis what he enforces in the module tree.
Ok, I will fix that too.

Thanks

Best regards
José Ignacio

