<?php
declare(strict_types=1);

namespace App\Console\Commands;

use Illuminate\Console\Command;

/**
 * CreateServiceFileCommand class
 */
class CreateServiceFileCommand extends Command
{
    /**
     * @const string services dir path
     */
    const SERVICES_PATH = 'app/Services/';

    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'make:service {serviceName : The name of service}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Create service files';

    /**
     * @var string
     */
    private $fileName;

    /**
     * @var string
     */
    private $dirName;

    /**
     * @var string
     */
    private $serviceFileName;

    /**
     * @var string
     */
    // private $interfaceFileName;

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
        $this->fileName = $this->argument('serviceName');

        if (is_null($this->fileName)) {
            $this->error('Service Name invalid');
        }
        $this->dirName = $this->ask('new directory name. or use directory name');

        if (!$this->isExistDirectory()) {
            $this->createDirectory();
        }

        if (is_null($this->dirName)) {
            $this->serviceFileName = self::SERVICES_PATH . $this->fileName . 'Service.php';
        } else {
            $this->serviceFileName = self::SERVICES_PATH . $this->dirName . '/' . $this->fileName . 'Service.php';
        }

        if ($this->isExistFiles()) {
            $this->error('already exist');
            return;
        }

        $this->creatServiceFile();
        $this->info('create successfully');
    }

    /**
     * Serviceのfileを作成する
     * @return void
     */
    private function creatServiceFile(): void
    {
        $content = "<?php\ndeclare(strict_types=1);\n\nnamespace App\\Services\\$this->dirName;\n\nclass $this->fileName" . "Service\n{";
        $content = $content . "\n\tprotected \$Interface;\n";
        $content = $content . "\n\tpublic function __construct(Interface \$Interface)\n\t{";
        $content = $content . "\n\t\t\$this->Interface = \$Interface;\n";
        $content = $content . "\t}\n";
        $content = $content . "}\n";
        file_put_contents($this->serviceFileName, $content);
    }


    /**
     * 同名fileの確認
     * @return bool
     */
    private function isExistFiles(): bool
    {
        return file_exists($this->serviceFileName);
    }

    /**
     * directoryの存在確認
     * @return bool
     */
    private function isExistDirectory(): bool
    {
        return file_exists(self::SERVICES_PATH . $this->dirName);
    }

    /**
     * 指定名でdirectoryの作成
     * @return void
     */
    private function createDirectory(): void
    {
        mkdir(self::SERVICES_PATH . $this->dirName, 0755, true);
    }
}