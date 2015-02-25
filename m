Return-Path: <mmarek@suse.cz>
Date: Wed, 25 Feb 2015 12:53:36 +0100
From: Michal Marek <mmarek@suse.cz>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
	Harish Jenny K N <harish_kandiga@mentor.com>,
	linux-modules <linux-modules@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	greg KH <gregkh@linuxfoundation.org>
Subject: Re: Differences between builtins and modules
Message-ID: <20150225115336.GA31354@sepie.suse.cz>
References: <CAKi4VA+1krn9rdBWE69DkhNZSrxJoeYzyPgvn-SUk8U0=CxFkw@mail.gmail.com>
 <54EB4C83.2000500@suse.cz>
 <CAKi4VAJwvtLaF1GTw1dg__CXHGjwOwJqUS=g5B0rbPNp1w8dDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKi4VAJwvtLaF1GTw1dg__CXHGjwOwJqUS=g5B0rbPNp1w8dDg@mail.gmail.com>
List-ID: <linux-modules.vger.kernel.org>

On Tue, Feb 24, 2015 at 10:02:55PM -0300, Lucas De Marchi wrote:
> On Mon, Feb 23, 2015 at 12:51 PM, Michal Marek <mmarek@suse.cz> wrote:
> > On 2015-02-23 15:30, Lucas De Marchi wrote:
> >> My questions are:
> >> 1) should we put *all* the "modules" in the builtin index?
> >
> > You mean all *.o files that do not end up in some *.ko? That won't work,
> > because unlike module names, the names of object files are not global.
> 
> I was actually meaning anything that can have a directory under
> /sys/module/. I figure we can't easily know this.

I see. Well, we could generate the .modinfo section also for builtin
object files and discard it from vmlinux later, like this:

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ac78910..efe1798 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -683,6 +683,7 @@
 	EXIT_CALL							\
 	*(.discard)							\
 	*(.discard.*)							\
+	*(.modinfo)							\
 	}
 
 /**
diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 1c9effa..f38abfa 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -16,23 +16,17 @@
 /* Chosen so that structs with an unsigned long line up. */
 #define MAX_PARAM_PREFIX_LEN (64 - sizeof(unsigned long))
 
-#ifdef MODULE
 #define __MODULE_INFO(tag, name, info)					  \
 static const char __UNIQUE_ID(name)[]					  \
   __used __attribute__((section(".modinfo"), unused, aligned(1)))	  \
   = __stringify(tag) "=" info
-#else  /* !MODULE */
-/* This struct is here for syntactic coherency, it is not used */
-#define __MODULE_INFO(tag, name, info)					  \
-  struct __UNIQUE_ID(name) {}
-#endif
 #define __MODULE_PARM_TYPE(name, _type)					  \
-  __MODULE_INFO(parmtype, name##type, #name ":" _type)
+  __MODULE_INFO(parmtype, name##type, MODULE_PARAM_PREFIX #name ":" _type)
 
 /* One for each parameter, describing how to use it.  Some files do
    multiple of these per line, so can't just use MODULE_INFO. */
 #define MODULE_PARM_DESC(_parm, desc) \
-	__MODULE_INFO(parm, _parm, #_parm ":" desc)
+	__MODULE_INFO(parm, _parm, MODULE_PARAM_PREFIX #_parm ":" desc)
 
 struct kernel_param;
 
Then some script would look at the parmtype= fields in the built-in.o
files and complement the list of builtin modules. However, the question
is whether this is worth it. As far as I understand, the problem is just
the discrepancy between modules.builtin and /sys/module. In practice, no
sane tool is going to need to modprobe 'vt' or 'printk', because there
is no configuration in which these modules would exist.


> > Plus, there was IIRC an idea to teach lsmod to print builtin modules --
> > listing all *.o would make it rather useless.
> 
> This was one of my ideas... to traverse /sys/module and give more
> information than we actually output right now, including builtin
> modules. However, given the fact that builtin modules only have an
> entry in /sys/module if they have params and now that I'm aware of the
> race between the creation of the directory and the initstate file, I'm
> giving up on this idea for now.

You could still print the module names from modules.builtin(.idx). But
this is an unrelated topic, I only brought it up because I did not
understand what you were proposing.

Michal
