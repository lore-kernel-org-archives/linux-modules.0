Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9629633C195
	for <linux-modules@vger.kernel.org>; Mon, 22 Dec 2025 20:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435104; cv=none; b=clZGAHoGZncvYBt+l4hKbCcWFqObTF2+X3v4kaZ/36O/0/xOCGbQdVpxJeSZZEbHZfJyTiGTQbmyDnOm7t7kRbYLMOSFrJwK2AMan0+3knQ9nBhEPNrXvo3QKKo94fLalcKnXKzZ6/xBHN2W9rXSM11WgnoRrG9gg9/CDzWid0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435104; c=relaxed/simple;
	bh=ajo+nok7r7S20w24V5z7hi/zIzLk0JH+l2h04qXckpg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kwfDYaSs3JqPusjV7Ocy9nhRp/Nsf7aGiOacbbSGaaNneuX8IyiDZD2PUv2VNu8JCf8BE1plXzXJP4Q9D5SivpYeCkrzbFwLeah+hwz/FRhqtihWFFG0clhiEZVdSut37JZOGtg4hW3P3zaFyZ3TgKLHyom/Zmrhooi/w/UjKco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WouRkIWQ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WouRkIWQ"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630753cc38so7622021a12.1
        for <linux-modules@vger.kernel.org>; Mon, 22 Dec 2025 12:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766435102; x=1767039902; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J/WrH5iuIyGTwZ2pSmtYKxZW4trS3oqc9njhYuUtN+k=;
        b=WouRkIWQ+Y1yoFpSSJ9/t/nLvSaB0Rz8PS/Vzx7TBMam74w8DYXTPxSeSfoyedivaH
         ShR0G4N7ANcIAHF67hAQrjPOWo260VtxiMpBFa5U3lCjWEr3wdGFL0BmyZbnan+GZyqh
         FAlgRrvziM5tYmAOmjNDzd3zKAzxwD9BguhWupsrXyZUCaWg+vTC4V05UyXQg3Uokin3
         4/Iw92US8pO02JAVXMcqZj8rpRzfIoizXWJ8KkNAljf2c7dZWy9Y26Ymc1bJl9FwhPhF
         hujQMWXv5CI4ziR/zXSI9ANvrYM8ucyK6gWeyinD9Am3L6hm3rtSkiUiiT1HgOHrkqfo
         3mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766435102; x=1767039902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/WrH5iuIyGTwZ2pSmtYKxZW4trS3oqc9njhYuUtN+k=;
        b=VohpPzr+/dYwdwxzzOaa5tAabXqfqLez9aFP85e+enNtGhQCnqIzi9FRr5/2VXbIs5
         F3KqSWwqaW15Tq6ZnfM6DjssHOBG/D9GkRvTP5rgo6eYQWYFgL4D/9x6C48XumpGxZA7
         1tfZQ6I4shbNxf0bkVROCl/CVc+HvBjuiiTwE0Fdw91bHckRRfeE8W9j7FbP9R3LOA9q
         xQmadCtPtgnFHOsFX7nWEmxnM/ctVJLXtb3gxhfDlmIf36vCW+Z2e9IZwws1uH5c1PDh
         QESCHeWhNydqcw6sDgaanyEaj0LJJwOndZktabJJ3tAs7LwRhLau4uMtQUBm0F3+GCgi
         7wcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe9pwPX3xbJVUtH/p+WOhsjXr7XiiKBtKEBWe1ftOxmJhoLf0GF7neKWm2dkeyyVFKTfHosZw27WzhuSvu@vger.kernel.org
X-Gm-Message-State: AOJu0YyKEnpqZ6VZIPiN2/mhzWXhvh5MSPjcuRXOrrJHKBQVWabS5vqq
	ujQVUd9mfCcRG+F471QptR7drmPtjHU3veOP84RQPlwHVBEKPHKpKE07yXWdUtDrBUUNP5eVJLn
	x/xrmHHnH5xdfT2PLLfhTHv6PMMx5Nw==
X-Google-Smtp-Source: AGHT+IHToN5439A8YFtYOR3bVsJC3zr7KhsH9+3M5t2C8tBoAPqchL1NoCjSNs5NVfRInI2CF/HPcWxKdr3WpwtIsjg=
X-Received: from dlb36.prod.google.com ([2002:a05:7022:624:b0:120:5707:d2e1])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2404:b0:11e:3e9:3ea3 with SMTP id a92af1059eb24-1217230f5edmr8182399c88.50.1766435101888;
 Mon, 22 Dec 2025 12:25:01 -0800 (PST)
Date: Mon, 22 Dec 2025 20:24:19 +0000
In-Reply-To: <20250819121248.460105-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819121248.460105-1-petr.pavlu@suse.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=418; i=samitolvanen@google.com;
 h=from:subject:message-id; bh=ajo+nok7r7S20w24V5z7hi/zIzLk0JH+l2h04qXckpg=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJmeK77umzzJb/+H0u6/NjuuR6p+tC9NXZkVlu7dmt3F8
 ficsGpfRykLgxgXg6yYIkvL19Vbd393Sn31uUgCZg4rE8gQBi5OAZjIoiqGPzxLO75L1U35H2h6
 X7LR+tD0+O2bbr51fNp7RWdeVZVoRgQjw5yF3d7L8hRr9ir4+s+KCMyvZ3i5PcDqPqfT6e9rt+3 nYAQA
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <176643400571.1902051.14506799084568458781.b4-ty@google.com>
Subject: Re: [PATCH] params: Replace __modinit with __init_or_module
From: Sami Tolvanen <samitolvanen@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, Shyam Saini <shyamsaini@linux.microsoft.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 19 Aug 2025 14:12:09 +0200, Petr Pavlu wrote:
> Remove the custom __modinit macro from kernel/params.c and instead use the
> common __init_or_module macro from include/linux/module.h. Both provide the
> same functionality.
> 
> 

Applied to modules-next, thanks!

[1/1] params: Replace __modinit with __init_or_module
      commit: 3cb0c3bdea5388519bc1bf575dca6421b133302b

Best regards,

	Sami

