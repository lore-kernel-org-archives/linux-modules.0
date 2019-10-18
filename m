Return-Path: <SRS0=u9gr=YL=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A88CA9EA3
	for <linux-modules@archiver.kernel.org>; Fri, 18 Oct 2019 09:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807A821897
	for <linux-modules@archiver.kernel.org>; Fri, 18 Oct 2019 09:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V/WZMWE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409751AbfJRJcB (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:32:01 -0400
Received: from mail-wm1-f73.google.com ([209.85.128.73]:51694 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395294AbfJRJcA (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 18 Oct 2019 05:32:00 -0400
Received: by mail-wm1-f73.google.com with SMTP id q22so2077637wmc.1
        for <linux-modules@vger.kernel.org>; Fri, 18 Oct 2019 02:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CefUdT/U9YxfsmGJOtKKbX2uOcNaLiHUwulgdJNO7YY=;
        b=V/WZMWE+vzEHrIgZiqUwjUYMEQO5dHruFItTRjoUuyxsdthMmDDFYhpqFTsyzoMbyH
         GlNzJ4ee8vpiXNxQCltBCH4bmXVqqGtpNSG+ZcwlFzeIGc1IvDUaELDR7EvfVM+k6hLy
         EVKdk47/4dAXRhDsoMO8/eHt/QcZFPWKSvxKkK7epUdVDCLITZ9w7Z1284Bj9yDmcZNp
         K35Z6ZE3sgX4LYOYQC2M5BrnXyB9FHIe51m/WZ8gu6oZH3aLuqKU91CFtp6ngpPlo20v
         VMGDLVeUZ6fGqP24sMuEJxNIPO7ZAcMJ9/fQrPmb/lwZRVDnbAXT/12T6a5JtlX7Fud6
         iJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CefUdT/U9YxfsmGJOtKKbX2uOcNaLiHUwulgdJNO7YY=;
        b=obfsVXVltTuOMPeg5rPMNqUJ1tlcZrHjy+1HUiKBZHD3fvi+o4vUyr3/j3JQRANpDv
         /N1V33aU9wsTHAcEJ7S2ExX6HC+6Hyb01L0uh8cj3A6w2pkl4APgby9uG4MDT/uFDQY3
         n+4x+ixvZxvOPAjBlzI2SUVCoKK1RSw4ykhbad2ssfuy2sb+eF7XqnCPb25gx0eMIcF3
         Fgi0AZMYOGg7F/nP6l5/qwCzr/MLRdMoDt4urVk5lVgDcgVI3T9p4TatMZJAJZ/ZI4zl
         0+WwBhMlkV30kjd/+SRlJg5aaTwXeN07ClPVe7vbkPT7AlhxxZDdQCZXhU+1hMJIAkG8
         vYxA==
X-Gm-Message-State: APjAAAVyBPLLGe252giw/34ZvuCKa6C067dcxlHpW6St0akTg0m/ra84
        sl5tuSGL7ZZN8cLkd05bU7tgIinGTfyQqQ==
X-Google-Smtp-Source: APXvYqxhkUfQt5VWFwQdDMb+SkNUBDFTPh114wjCVU3PP5X13myEwoC/0C1rJzpB5HyPbQYsA03ZPFncjqJbQA==
X-Received: by 2002:adf:828c:: with SMTP id 12mr6904593wrc.40.1571391116693;
 Fri, 18 Oct 2019 02:31:56 -0700 (PDT)
Date:   Fri, 18 Oct 2019 10:31:39 +0100
In-Reply-To: <20191010151443.7399-1-maennich@google.com>
Message-Id: <20191018093143.15997-1-maennich@google.com>
Mime-Version: 1.0
References: <20191010151443.7399-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 0/4] export/modpost: avoid renaming __ksymtab entries for
 symbol namespaces
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com,
        Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Martijn Coenen <maco@android.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Shaun Ruffell <sruffell@sruffell.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

The introduction of the symbol namespace patches changed the way symbols are
named in the ksymtab entries. That caused userland tools to fail (such as
kmod's depmod). As depmod is used as part of the kernel build it was worth
having another look whether this name change can be avoided.

The main purpose of this series is to restore the original ksymtab entry names.
For that to happen and to remove some rough edges around that, the relevant
parts in modpost got a small refactoring as to when and how namespaces are
evaluated and set in the symbol struct.

Eventually, the namespace values can be read from __kstrtabns_ entries and
their corresponding __ksymtab_strings values. That removes the need to carry
the namespace names within the (anyway unique) symbol name entries.

The last patch of this series is adopted from Masahiro [1]. By allowing 'no
namespace' to be represented as empty string, large chunks of
include/linux/export.h could be consolidated. Technically, this last patch is
not absolutely necessary to fix functionality. It addresses concerns about
maintainability and readability. While I strongly suggest sending all of the
patches for 5.4, the last one could possible deferred to the next merge window.

This patch applies to the modules-linus [2] branch.

Changes since v2:
 - restored correct authorship for [4/4]
 - add missing contributor tags
 - fixed typos and code style (spaces/tabs)

[1] https://lore.kernel.org/lkml/20190927093603.9140-5-yamada.masahiro@socionext.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git/log/?h=modules-linus

Cc: Jessica Yu <jeyu@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Martijn Coenen <maco@android.com>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Shaun Ruffell <sruffell@sruffell.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Will Deacon <will@kernel.org>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-modules@vger.kernel.org


Masahiro Yamada (1):
  export: avoid code duplication in include/linux/export.h

Matthias Maennich (3):
  modpost: delegate updating namespaces to separate function
  modpost: make updating the symbol namespace explicit
  symbol namespaces: revert to previous __ksymtab name scheme

 include/linux/export.h | 97 +++++++++++++-----------------------------
 kernel/module.c        |  2 +-
 scripts/mod/modpost.c  | 59 ++++++++++++++++---------
 scripts/mod/modpost.h  |  1 +
 4 files changed, 71 insertions(+), 88 deletions(-)

Interdiff against v1:
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 7cf0065ac95f..0bf7eab80d9f 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -357,18 +357,21 @@ static const char *namespace_from_kstrtabns(struct elf_info *info,
 
 static void sym_update_namespace(const char *symname, const char *namespace)
 {
-       struct symbol *s = find_symbol(symname);
-       /* That symbol should have been created earlier and thus this is
-        * actually an assertion. */
-       if (!s) {
-               merror("Could not update namespace(%s) for symbol %s\n",
-                      namespace, symname);
-               return;
-       }
-
-       free(s->namespace);
-       s->namespace =
-	       namespace && namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
+	struct symbol *s = find_symbol(symname);
+
+	/*
+	 * That symbol should have been created earlier and thus this is
+	 * actually an assertion.
+	 */
+	if (!s) {
+		merror("Could not update namespace(%s) for symbol %s\n",
+		       namespace, symname);
+		return;
+	}
+
+	free(s->namespace);
+	s->namespace =
+		namespace && namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
 }
 
 /**
-- 
2.23.0.866.gb869b98d4c-goog

