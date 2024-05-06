Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923713C00
	for <linux-modules@vger.kernel.org>; Mon,  6 May 2024 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714999006; cv=none; b=pZgHfNRx8/4+9DTqz4zRWmY2kqT712SIOrgxJmZ5DVYZYAZdZHHkUDsJ4B4OH99vBqSxeR7BejTVo6XSKZrH/SVzJvkBaQz4dqhPcctLVPOJeD6Vnc0g07y4DF9ObCLIkAYtH9La7glWgTa9OMwNJJ+hBy4oAkHvMF5zfbnS1Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714999006; c=relaxed/simple;
	bh=mV+oaEHJcdm3/3wRQ/lnbWGHEBLmKf1UfZZlx3952AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BU7rkznlbziAGc+xUT7CoQV5y0octeFucg9qLnhrHe/krxV7ncXWMc4IOPIeJZeofRA3u+7vqC01koyTJhEcw63dZzZbz6I2BVjyNLsEdz5MJdcxMAKTojpjMTJLoaOrPjdN/TkAKPYLun7ntomYLOohbxsTaE/E4weHusNiSaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TPdh2lVW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPdh2lVW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714999003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mV+oaEHJcdm3/3wRQ/lnbWGHEBLmKf1UfZZlx3952AU=;
	b=TPdh2lVWHKXSB4YpHE4PCpInYrNYqxvCdEWlZQpSP8Bne5dUGMQvrf25CICI5Hk1OYpRKm
	jfFSzLDyYFhYGV0Xa9T2GWsfx50eDmpynbg8HZKhxtt+qYnWmlUCPztYYW7qHoJQVd8CTI
	gUpI/dhFDY6WsY6Q2GeqdTdaN7phNxI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-fgNsyTZLNMWFcPXb3JhGug-1; Mon,
 06 May 2024 08:36:38 -0400
X-MC-Unique: fgNsyTZLNMWFcPXb3JhGug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6C813C025C9;
	Mon,  6 May 2024 12:36:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.190])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 41A0F200A3BB;
	Mon,  6 May 2024 12:36:36 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jtornosm@redhat.com
Cc: emil.l.velikov@gmail.com,
	gustavo.sousa@intel.com,
	linux-modules@vger.kernel.org,
	lucas.demarchi@intel.com,
	mcgrof@kernel.org,
	md@linux.it
Subject: Re: [PATCH v2 patch] libkmod: add weak dependecies
Date: Mon,  6 May 2024 14:36:02 +0200
Message-ID: <20240506123634.14246-1-jtornosm@redhat.com>
In-Reply-To: <20240409155035.524993-1-jtornosm@redhat.com>
References: <20240409155035.524993-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hello Lucas,

If you have time, let me ask you about the status of the weak dependency feature.
Do you have any feedback/review for me?
Should I do something to improve it and/or progress?

Thanks in advance

Best regards
José Ignacio


