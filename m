Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244A614AD36
	for <linux-modules@vger.kernel.org>; Thu,  9 May 2024 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715248647; cv=none; b=FqxAKpbU72/6mYFX5EMZgIGhSBKqQfPrvsXXds7p/qO+EFrfiB1iVuaLDPOYRbYJu3MagwdiOX/mS72ohfx5t1b/F3eAkV6X5zHd38HQ61FyAfnIiP+fuF3yc3t0+Y9L871fVw98OGM2ZiiNlo7HJV1xQTkf3tMBRB1r8PIHn4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715248647; c=relaxed/simple;
	bh=PcEpipLiUhTvFEuzpKzBzEoyUx54hbRBhr2b9j8VFWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWutmWxMupRS+0Dz9cs2mE//sHlIzi86GsMZ61BWO2nd4mONICJE4ik6YATlUE2Q6qcPjbsE8CMTAesjjqIl0F6TMpgKVoqLKf2oadqR0GARirfaV+F8H6oWxgj24mOExFYru1514pQMKiCX4jMC+81vOALGLKV99LESqVNEPa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TFd2dChu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFd2dChu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715248643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcEpipLiUhTvFEuzpKzBzEoyUx54hbRBhr2b9j8VFWo=;
	b=TFd2dChuXXaBO4qDYzuWqlseAaMOeT1pJ1LIKnXUnUVvPzZLtU6vaWADrW6NLo8TOZaAdd
	65j1xTmrTBGX+jS3WeU55P7I2rpO+TL9o5TE6nDE3qeQ3+JjjEiiye68tR8TMFQTixxi8u
	E4kDo8Olgkxks7EQoVLbZWAg4eJ2hR0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-U56vMcNYMZ2XwjQ8dRpiYA-1; Thu,
 09 May 2024 05:57:20 -0400
X-MC-Unique: U56vMcNYMZ2XwjQ8dRpiYA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E35953C0C101;
	Thu,  9 May 2024 09:57:19 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 37C1E1C0D100;
	Thu,  9 May 2024 09:57:17 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: lucas.demarchi@intel.com
Cc: emil.velikov@collabora.com,
	gustavo.sousa@intel.com,
	jtornosm@redhat.com,
	linux-modules@vger.kernel.org,
	mcgrof@kernel.org,
	md@linux.it
Subject: Re: [PATCH v2 patch] libkmod: add weak dependecies
Date: Thu,  9 May 2024 11:57:11 +0200
Message-ID: <20240509095717.94830-1-jtornosm@redhat.com>
In-Reply-To: <7dttsdaxjsxr5dk5ki5mgasqrihobioyyn44l54k5jmf6ijspv@lodmzcimdin7>
References: <7dttsdaxjsxr5dk5ki5mgasqrihobioyyn44l54k5jmf6ijspv@lodmzcimdin7>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

>> kmod_config_add_weakdep ...
> this is a long function that we may eventually break in smaller pieces
> and share with the softdep parser.
>> weakdep_to_char ...
> ditto for this one
> I'd keep this in a separate patch, but ok.
> things look good here, thanks for doing this
Ok, let me have a look to get more modular functions in a later patch.

> I think next step would be to add some tests to our testsuite to make
> sure we are parsing things correctly. Could you take a look in in
> `git grep softdep` testsuite/ to take inspiration on how to write one
> for weakdep? it seems we only have 1 test for a failure scenrario, but
> we could add more too.
>
>Tests I'm looking for:
>
> 1) make sure we don't load a module due to being a weakdep
> 2) make sure depmod outputs the weakdep correctly
> 3) make sure the weakdep is parsed correctly from the conf file
Ok, I will complete with some tests as you comment in another later patch.
I will try to cover at least what you say.

Regarding the necessary kernel patch I will re-submit it, adding that
the weak procedure is already included in kmod.

Thank you

Best regards
José Ignacio

