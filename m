Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98131A3BC6
	for <linux-modules@vger.kernel.org>; Wed, 25 Sep 2024 23:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307567; cv=none; b=W6EAi/tbYjJ9R6UUm4AHYa+2mtKCFc/bfR35UyNAK8FoT8wSNROzaUKe40U7iloNnBTVlT+ZhCJQrE5H3UAgEJlyXb29DxwJDPuAE8QOQA9i27mVu+KjbQCzDok83pFcHnBHpivVO0yvN0HlGRdqZKY3Le8cqyntj40WVwl6sWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307567; c=relaxed/simple;
	bh=87UiLghCgImjI67qGqkZVlUAdkIatHILzWkWX7E7o4U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R9A+78LpF9qRfIDgdTKsAMOreOz+H7kGMWydggBlCBLEuKwqh5lXtcPLjYX7yacYi59WqbTD1uk/eu1NhGiyGTbKLrPRbwoE5ZrrkoSQZUq0wl+QgUJWOaO3pH5VMIyXd8p+dWrLmo985BQecXQRI9ni4J8XuLrlwXkjfAldLSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sSv2LwGg; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sSv2LwGg"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so726236276.0
        for <linux-modules@vger.kernel.org>; Wed, 25 Sep 2024 16:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727307563; x=1727912363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LyxbaKZI7M7/7zXNo9r/7MnbWQPTGkdTyXhoBixsIfc=;
        b=sSv2LwGgnR8j+P3liOLGDS+Gd7WpWyGEpltfC2fOq9aHCnwHqKpAttF7d+ujur0gB8
         uajSGw9bVI1blAghnlpJjKpoTU8usQLS1/X50XZcXRK2ld2nldpX0shMzOrzMTxdVLIJ
         o2OFB6nS8m8f30g49HHszNUg4NYHQ7YOfOnn0pR3DzgI2jh4Ex0z/zxC6aNfqKlvgEJB
         r/zziTXy3Y/X9G/QWZlE+NWZ6N6MwuehcCCRkvO/+09LtjzKlTZoKwgwXnRpuHJO48eN
         eg7WXZaSbwse0lfJZGVqJ0XJl+5015CPNqjSCTK27vwULOfZQfEkq5wL2ShUhcw7U2j6
         u2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727307563; x=1727912363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LyxbaKZI7M7/7zXNo9r/7MnbWQPTGkdTyXhoBixsIfc=;
        b=cykngdVN9ZDzE5NvOVdHEqYtrF6Qp2r5FiTiFKUZ6EdC4xCA0TkUmdpiYvOeWCHr8s
         fg+NlcvhFdnoT/yPYbL1XpALJ/NSX6Kn+uJFpvGKm6QAKXj7xFMhRlfyvRmd78KzMU+W
         oD9BsJvg1yf1v8Xlik0kteyubVa4h8GcV7FxtMNBJNXVEkZ+sMi7Znyy4HtplHGKozoK
         iel1k9+gkirCwIxXgQT0GBXCNlhaQArAWAa1oEmnrUP5ONpX5S849MXDgdZ+yh8F9vrm
         AHf7p4S+We9ybddZOtYvsKaYxkKumQzcqGOvU86p5OjMhcOF8gtDxy7vb1XL/p9SlVt+
         rNIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqtL39vQsbcY/DUuBqu87i8usvbgQYzDZUg9dE4Aqpo0rOVqU7zzmkc18PiQHP3IRMMXH45V2zTte8VBIw@vger.kernel.org
X-Gm-Message-State: AOJu0YwcGuxb0lajNV33jRAIv5d50Q1UJLjLvksRrCvd+yO8cXUDjiVe
	eNQExnwSn0ZD558/WfX1rCD1PK0AsislkMwgPoJFSlzKxKrTdQdYcvXl1p46S6v5fK0tWSnl+AL
	YzCAiXg==
X-Google-Smtp-Source: AGHT+IEL4w0/gR8iE4pApg14NOFOUxZBPfsQ63YvAHEvZzW8W2ulmi1Lrysl9VB/6vA6caGgF7tNgGtZN5yi
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6902:2e88:b0:e22:5f73:1701 with SMTP
 id 3f1490d57ef6-e24d44c8e18mr28465276.0.1727307563386; Wed, 25 Sep 2024
 16:39:23 -0700 (PDT)
Date: Wed, 25 Sep 2024 23:38:16 +0000
In-Reply-To: <20240925233854.90072-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925233854.90072-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240925233854.90072-2-mmaurer@google.com>
Subject: [PATCH v5 01/16] module: Take const arg in validate_section_offset
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, linux-modules@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"

`validate_section_offset` doesn't modify the info passed in. Make this
clear by adjusting the type signature.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 49b9bca9de12..1a2dd52147ba 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1645,7 +1645,7 @@ bool __weak module_exit_section(const char *name)
 	return strstarts(name, ".exit");
 }
 
-static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
+static int validate_section_offset(const struct load_info *info, Elf_Shdr *shdr)
 {
 #if defined(CONFIG_64BIT)
 	unsigned long long secend;
-- 
2.46.1.824.gd892dcdcdd-goog

