import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/task.dart';
import '../services/database_service.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;
  
  AddTaskScreen({this.task});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedPriority = 'medium';
  bool _isLoading = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<String> _priorities = ['low', 'medium', 'high'];
  final Map<String, Color> _priorityColors = {
    'low': Colors.green,
    'medium': Colors.orange,
    'high': Colors.red,
  };

  final Map<String, IconData> _priorityIcons = {
    'low': Icons.keyboard_arrow_down,
    'medium': Icons.remove,
    'high': Icons.keyboard_arrow_up,
  };

  final Map<String, String> _priorityLabels = {
    'low': 'BAJA',
    'medium': 'MEDIA',
    'high': 'ALTA',
  };

  final Map<String, String> _priorityDescriptions = {
    'low': 'Se puede hacer cuando tengas tiempo libre',
    'medium': 'Debería completarse pronto',
    'high': 'Necesita atención inmediata',
  };

  @override
  void initState() {
    super.initState();
    
    // Inicializar animaciones
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    
    // Llenar campos si es edición
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _selectedPriority = widget.task!.priority;
    }
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade400,
              Colors.purple.shade400,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header con animación
              FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.task == null ? 'Crear Nueva Tarea' : 'Editar Tarea',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              widget.task == null 
                                  ? 'Agrega una nueva tarea a tu lista' 
                                  : 'Actualiza los detalles de tu tarea',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Formulario con animación
              Expanded(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: 10),
                                
                                // Campo de título
                                _buildSectionTitle('Título de la Tarea'),
                                SizedBox(height: 12),
                                _buildTitleField(),
                                
                                SizedBox(height: 24),
                                
                                // Campo de descripción
                                _buildSectionTitle('Descripción'),
                                SizedBox(height: 12),
                                _buildDescriptionField(),
                                
                                SizedBox(height: 24),
                                
                                // Selector de prioridad
                                _buildSectionTitle('Nivel de Prioridad'),
                                SizedBox(height: 12),
                                _buildPrioritySelector(),
                                
                                SizedBox(height: 40),
                                
                                // Botón de guardar
                                _buildSaveButton(),
                                
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      decoration: InputDecoration(
        hintText: 'Ingresa un título descriptivo para tu tarea',
        prefixIcon: Icon(Icons.title, color: Colors.blue.shade400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: EdgeInsets.all(20),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
        ),
      ),
      style: GoogleFonts.poppins(fontSize: 16),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Por favor ingresa un título para la tarea';
        }
        if (value.trim().length < 3) {
          return 'El título debe tener al menos 3 caracteres';
        }
        return null;
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Describe qué necesita ser hecho...',
        prefixIcon: Padding(
          padding: EdgeInsets.only(bottom: 60),
          child: Icon(Icons.description, color: Colors.blue.shade400),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: EdgeInsets.all(20),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
        ),
      ),
      style: GoogleFonts.poppins(fontSize: 16),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Por favor ingresa una descripción';
        }
        if (value.trim().length < 10) {
          return 'La descripción debe tener al menos 10 caracteres';
        }
        return null;
      },
    );
  }

  Widget _buildPrioritySelector() {
    return Column(
      children: _priorities.map((priority) {
        final isSelected = _selectedPriority == priority;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedPriority = priority;
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? _priorityColors[priority]!.withOpacity(0.1)
                  : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isSelected
                    ? _priorityColors[priority]!
                    : Colors.grey.shade200,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _priorityColors[priority]!.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    _priorityIcons[priority]!,
                    color: _priorityColors[priority]!,
                    size: 20,
                  ),
                ),
                
                SizedBox(width: 16),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PRIORIDAD ${_priorityLabels[priority]!}',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? _priorityColors[priority]!
                              : Colors.grey.shade700,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        _priorityDescriptions[priority]!,
                        style: GoogleFonts.poppins(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: _priorityColors[priority]!,
                    size: 24,
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _saveTask,
      child: Container(
        height: 56,
        child: Center(
          child: _isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.task == null ? Icons.add : Icons.update,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      widget.task == null ? 'CREAR TAREA' : 'ACTUALIZAR TAREA',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade400,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0,
      ),
    );
  }

  Future<void> _saveTask() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final task = Task(
          id: widget.task?.id,
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          priority: _selectedPriority,
          createdAt: widget.task?.createdAt ?? DateTime.now(),
          isCompleted: widget.task?.isCompleted ?? false,
          completedAt: widget.task?.completedAt,
        );

        if (widget.task == null) {
          await DatabaseService.instance.createTask(task);
        } else {
          await DatabaseService.instance.updateTask(task);
        }

        // Mostrar snackbar de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.task == null 
                  ? '¡Tarea creada exitosamente!' 
                  : '¡Tarea actualizada exitosamente!',
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: Colors.green.shade400,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );

        Navigator.pop(context);
      } catch (e) {
        // Mostrar error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error al guardar la tarea. Intenta de nuevo.',
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: Colors.red.shade400,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}